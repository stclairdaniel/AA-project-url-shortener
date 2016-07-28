class AddTaggingIdToShortenedUrl < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :tagging_id, :integer
  end
end
