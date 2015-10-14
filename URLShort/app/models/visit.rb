class Visit < ActiveRecord::Base
  belongs_to(
    :visitor,
    class_name: 'User',
    foreign_key: :visitor_id,
    primary_key: :id
  )

  belongs_to(
    :shortened_url,
    class_name: 'ShortenedUrl',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )
end
