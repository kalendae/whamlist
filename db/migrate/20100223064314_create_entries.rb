class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :feed_id
      t.string :link
      t.string :title
      t.datetime :published
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
