# == Schema Information
# Schema version: 20090605012055
#
# Table name: artifact_group_list
#
#  group_artifact_id   :integer         not null, primary key
#  group_id            :integer         not null
#  name                :text
#  description         :text
#  is_public           :integer         default(0), not null
#  allow_anon          :integer         default(0), not null
#  email_all_updates   :integer         default(0), not null
#  email_address       :text            not null
#  due_period          :integer         default(2592000), not null
#  use_resolution      :integer         default(0), not null
#  submit_instructions :text
#  browse_instructions :text
#  datatype            :integer         default(0), not null
#  status_timeout      :integer
#

class ArtifactGroupList < ActiveRecord::Base

  set_table_name 'artifact_group_list'
  set_primary_key 'group_artifact_id'
  
  belongs_to :group
  has_many :artifacts, :foreign_key => 'group_artifact_id' # TODO probably dependent => :destroy 

end
