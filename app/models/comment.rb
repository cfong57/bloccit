class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :post, :image

  mount_uploader :image, ImageUploader

  default_scope order('updated_at DESC')
  validates :body, length: { minimum: 5 }, presence: true
  validates :post, presence: true
  validates :user, presence: true  

  after_create :send_favorite_emails

  default_scope order('updated_at DESC')

  private

  def send_favorite_emails
    self.post.favorites.each do |favorite|
      #do not notify users when they themsevles comment on post they've favorited, because that's just silly
      if favorite.user_id != self.user_id && favorite.user.email_favorites?
        FavoriteMailer.new_comment(favorite.user, self.post, self).deliver
      end
    end
  end
end
