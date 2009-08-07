# == Schema Information
# Schema version: 20090605012055
#
# Table name: artifact_history
#
#  id          :integer         not null, primary key
#  artifact_id :integer         default(0), not null
#  field_name  :text            default(""), not null
#  old_value   :text            default(""), not null
#  mod_by      :integer         default(0), not null
#  entrydate   :integer         default(0), not null
#

class ArtifactHistory < ActiveRecord::Base
  
  set_table_name 'artifact_history'
  
  belongs_to :artifact
  
end
