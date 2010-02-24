class CreateEntriesUsers < ActiveRecord::Migration
  def self.up
    create_table :entries_users, :id => false do |t|
      t.integer :entry_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :entries_users
  end
end
