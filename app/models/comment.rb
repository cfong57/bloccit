class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :body, :post, :image

  mount_uploader :image, ImageUploader

  default_scope order('updated_at DESC')
  validates :body, length: { minimum: 5 }, presence: true
  validates :post, presence: true
  validates :user, presence: true  
end
