class AddIndexToTaggings < ActiveRecord::Migration
  def change
    add_index :taggings, :tag_topic_id
    add_index :taggings, :url_id
  end
end
