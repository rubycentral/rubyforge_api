# == Schema Information
# Schema version: 20090605012055
#
# Table name: artifact_message
#
#  id           :integer         not null, primary key
#  artifact_id  :integer         not null
#  submitted_by :integer         not null
#  from_email   :text            not null
#  adddate      :integer         default(0), not null
#  body         :text            not null
#

class ArtifactMessage < ActiveRecord::Base

  set_table_name 'artifact_message'
  
  belongs_to :artifact
  belongs_to :submitted_by, :class_name => 'User', :foreign_key => 'submitted_by'
  
end
