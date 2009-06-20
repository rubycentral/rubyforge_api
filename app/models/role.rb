class Role < ActiveRecord::Base

  set_table_name 'role'
  set_primary_key 'role_id'

  belongs_to :group
  
  validates_presence_of :role_name, :group_id

end