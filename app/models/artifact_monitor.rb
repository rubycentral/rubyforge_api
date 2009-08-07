# == Schema Information
# Schema version: 20090605012055
#
# Table name: artifact_monitor
#
#  id          :integer         not null, primary key
#  artifact_id :integer         not null
#  user_id     :integer         not null
#  email       :text
#

class ArtifactMonitor < ActiveRecord::Base

  set_table_name 'artifact_monitor'
  
  belongs_to :artifact
  belongs_to :user
  
end
