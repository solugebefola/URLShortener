class RemoveIndex2 < ActiveRecord::Migration
  def change
    remove_index :shortened_urls, name: "index_shortened_urls_on_submitter_id"
  end
end
