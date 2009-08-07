# == Schema Information
# Schema version: 20090605012055
#
# Table name: role
#
#  role_id   :integer         not null, primary key
#  group_id  :integer         not null
#  role_name :text
#

class Role < ActiveRecord::Base

  set_table_name 'role'
  set_primary_key 'role_id'

  belongs_to :group
  
  validates_presence_of :role_name, :group_id

end
