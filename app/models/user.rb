class User < ActiveRecord::Base
  has_secure_password
  validates :yo_username, presence: true, uniqueness: true

  YO_API_ENDPOINT = 'http://api.justyo.co/yo'

  def self.find_and_authenticate(email, password)
    find_by(email: email).try(:authenticate, password)
  end

  def eligible_for_authentication
    yo_tfa_sent_at + 2.minutes < Time.now
  end

  def send_yo_link(link)
    RestClient.post(YO_API_ENDPOINT, api_token: ENV['YO_API_KEY'], username: yo_username, link: link)
  end
end
