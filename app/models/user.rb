class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  validates :yo_username, presence: true, uniqueness: true

  YO_API_ENDPOINT = 'http://api.justyo.co/yo/'

  def eligible_for_authentication?
    yo_tfa_sent_at + 2.minutes < Time.now
  end

  def send_yo_link
    self.yo_tfa_sent_at = Time.now
    self.save!
    RestClient.post(YO_API_ENDPOINT, api_token: ENV['YO_API_KEY'], username: yo_username, link: create_confirm_link)
  end

  private
  def create_confirm_link
    "#{root_url}users/sesame/#{create_token}"
  end

  def create_token
    token = Digest::SHA1.hexdigest("#{ENV['SECURE_CONFIRM']}#{Time.now}")
    self.token = token
    self.save!
    token
  end
end
