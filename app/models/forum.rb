class Forum < ActiveRecord::Base
  acts_as_list

  validates :name, :presence => true
  
  has_many :topics, :class_name => "ForumTopic", :order => "updated_at DESC", :dependent => :destroy

  has_many :posts, :through => :topics
  
end
