class Topic < ActiveRecord::Base
  attr_accessible :description, :name, :public
  has_many :posts

  default_scope order('updated_at DESC')
end
