class ChangeLongUrlType < ActiveRecord::Migration
  def up
    change_column :shortened_urls, :long_url, :string
  end

  def down
    change_column :shortened_urls, :long_url, :text
  end
end
