class DiskUsage < ActiveRecord::Base

  belongs_to :group

  validates_presence_of :group_id

end
