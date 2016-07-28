class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_topic_id
      t.integer :url_id

      t.timestamps null: false
    end
  end
end
