class User < ActiveRecord::Base
  has_secure_password
  validates :email, :yo_username, presence: true, uniqueness: true

  def self.find_and_authenticate(email, password)
    find_by(email: email).try(:authenticate, password)
  end
end
