class Feed < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :submitter, :class_name => 'User', :foreign_key => 'submitter_id'

  def self.recent limit = 10
    self.find(:all, :limit => limit, :order => "created_at desc")
  end
  
end
