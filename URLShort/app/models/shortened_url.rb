require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  include SecureRandom
  validates :submitter_id, presence: true, uniqueness: true

  def self.random_code
    random = SecureRandom.urlsafe_base64(16)

    while random.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64(16)
    end

    random
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.new(user.id, long_url, random_code)
  end

  def initialize(submitter_id, long_url, short_url)
    @submitter_id, @long_url, @short_url = submitter_id, long_url, short_url
  end

end
