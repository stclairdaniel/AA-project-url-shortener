class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.text :short_url
      t.text :long_url
      t.integer :user_id
      t.timestamps null: false
    end

    add_index :shortened_urls, :short_url
  end
end
