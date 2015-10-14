require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  include SecureRandom
  validates :submitter_id, presence: true, uniqueness: true

  belongs_to(
    :submitter,
    :class_name =>  'User',
    :foreign_key => :submitter_id,
    :primary_key => :id
    )

  def self.random_code
    random = SecureRandom.urlsafe_base64(16)

    while self.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64(16)
    end

    random
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(submitter_id: user.id, long_url: long_url, short_url: random_code)
  end

end
