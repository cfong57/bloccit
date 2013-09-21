class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  attr_accessible :body, :title, :topic, :image

  after_create :create_vote
  after_create :send_favorite_emails

  mount_uploader :image, ImageUploader

  def up_votes
    self.votes.where(value: 1).count
  end

  def down_votes
    self.votes.where(value: -1).count
  end  

  def points
    self.votes.sum(:value).to_i
  end  

  # 1. Determine the age of the post by subtracting its created_at time from a standard time. 
  # A standard time in this context is known as an epoch. This gives us an age in seconds. 
  # By doing this, newer posts start with a higher ranking, and the relative ranking of older 
  # posts will decay over time;
  # 2. Divide the age (currently in seconds) by the number of seconds in a day (86,400). This gives 
  # us the age in days;
  # 3. Add the points (i.e. sum of the votes) to the age. This means that the passing of one day will
  # be equivalent to one down vote;
  # 4. Finally, update the post's rank attribute with the new_rank calculated by the algorithm.

  def update_rank
    age = (self.created_at - Time.new(1970,1,1)) / 86400
    new_rank = points + age

    self.update_attribute(:rank, new_rank)
  end

  default_scope order('rank DESC')

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true  
  #format: /herp|derp/

  private

  # Whoever created a post should automatically be set to "voting" it up.
  def create_vote
    user.votes.create(value: 1, post: self)
  end  

  def send_favorite_emails
    self.topic.favorites.each do |favorite|
      #do not notify users when they themsevles post on topic they've favorited, because that's just silly
      FavoriteMailer.new_post(favorite.user, self.topic, self).deliver unless favorite.user == self.user
    end
  end
end
