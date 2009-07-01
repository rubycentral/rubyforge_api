# == Schema Information
#
# Table name: user_group
#
#  user_group_id  :integer         not null
#  user_id        :integer         default(0), not null
#  group_id       :integer         default(0), not null
#  admin_flags    :string(16)      default(""), not null
#  forum_flags    :integer         default(0), not null
#  project_flags  :integer         default(2), not null
#  doc_flags      :integer         default(0), not null
#  cvs_flags      :integer         default(1), not null
#  member_role    :integer         default(100), not null
#  release_flags  :integer         default(0), not null
#  artifact_flags :integer
#  sys_state      :string(1)       default("N")
#  sys_cvs_state  :string(1)       default("N")
#  role_id        :integer         default(1)
#

class UserGroup < ActiveRecord::Base

  set_table_name "user_group"
  set_primary_key 'user_group_id'

  belongs_to :user
  belongs_to :group
  
  def has_release_permissions?
    release_flags == 1
  end
  
  def grant_release_permissions!
    self.release_flags = 1
    save
  end
  
  def group_admin?
    admin_flags.strip == 'A'
  end
end

