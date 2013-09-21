class Favorite < ActiveRecord::Base
  belongs_to :post
  #belongs_to :topic
  belongs_to :user
  attr_accessible :post #, :topic
end
