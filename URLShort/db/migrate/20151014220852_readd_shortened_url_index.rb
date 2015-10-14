class ReaddShortenedUrlIndex < ActiveRecord::Migration
  def change
    add_index :shortened_urls, :short_url
    add_index :shortened_urls, :submitter_id
  end
end
