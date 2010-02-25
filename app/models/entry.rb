class Entry < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :feed

  validates_uniqueness_of :link, :scope => [:feed_id]
end
