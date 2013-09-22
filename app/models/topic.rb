class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public, :image
  has_many :posts, dependent: :destroy
  #has_many :favorites, dependent: :destroy

  mount_uploader :image, ImageUploader

  default_scope order('updated_at DESC')
  validates :name, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 20 }, presence: true

  #private topics only visible to signed in users
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }
end
