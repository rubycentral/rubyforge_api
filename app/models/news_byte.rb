class NewsByte < ActiveRecord::Base
  
  belongs_to :group
  belongs_to :forum_group, :foreign_key => 'forum_id'
  
end