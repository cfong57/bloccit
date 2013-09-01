class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  attr_accessible :body, :title

  default_scope order('created_at DESC')
end
