class FixShortenedUrlsIndex < ActiveRecord::Migration
  def change
    remove_index :shortened_urls, name: "index_shortened_urls_on_short_url"
  end
end
