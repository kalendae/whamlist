class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.integer :submitter_id
      t.string :feed_url
      t.string :title
      t.datetime :last_grab

      t.timestamps
    end
  end

  def self.down
    drop_table :feeds
  end
end
