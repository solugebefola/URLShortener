require 'securerandom'

class ShortenedUrl < ActiveRecord::Base
  include SecureRandom
  validates :submitter_id, presence: true

  belongs_to(
    :submitter,
    class_name:   'User',
    foreign_key:  :submitter_id,
    primary_key:  :id
    )

  has_many(
    :visits,
    class_name:   'Visit',
    foreign_key:  :shortened_url_id,
    primary_key:  :id
  )

  has_many(
    :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor
  )

  def self.random_code
    random = SecureRandom.urlsafe_base64(16)

    while self.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64(16)
    end

    random
  end

  def self.create_for_user_and_long_url!(user, long_url)
    new_random_code = self.random_code.to_s
    self.create!(
      submitter_id: user.id,
      long_url: long_url,
      short_url: new_random_code
    )

    new_random_code
  end

  def num_clicks
    Visit.where("shortened_url_id = ?", self.id).count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    Visit.select(:visitor_id).where(
    "created_at > ? AND shortened_url_id = ?", 10.minutes.ago, self.id
    ).distinct.count
  end

end
