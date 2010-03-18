class User < ActiveRecord::Base

  acts_as_authentic
  
  validates_uniqueness_of :email
  validates_presence_of :email
  validates_presence_of :crypted_password
end
