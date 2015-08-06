class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :username, :password
  validates_uniqueness_of :username 

  def to_param
    "dashboard"
  end

end