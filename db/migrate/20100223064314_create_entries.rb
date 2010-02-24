class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :feed_id
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
