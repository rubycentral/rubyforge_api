class NewsByte < ActiveRecord::Base
  
  belongs_to :group
  belongs_to :forum_group, :foreign_key => 'forum_id'
  belongs_to :submitted_by, :class_name => 'User', :foreign_key => 'submitted_by'
  
end