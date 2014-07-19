class User < ActiveRecord::Base
  has_secure_password
  validates :email, :yo_username, presence: true, uniqueness: true
end
