class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  attr_accessible :body, :title
end
