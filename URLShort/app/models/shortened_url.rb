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

end
