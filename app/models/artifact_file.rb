# == Schema Information
# Schema version: 20090605012055
#
# Table name: artifact_file
#
#  id           :integer         not null, primary key
#  artifact_id  :integer         not null
#  description  :text            not null
#  bin_data     :text            not null
#  filename     :text            not null
#  filesize     :integer         not null
#  filetype     :text            not null
#  adddate      :integer         default(0), not null
#  submitted_by :integer         not null
#

class ArtifactFile < ActiveRecord::Base

  set_table_name :artifact_file
  
  belongs_to :artifact
  
end
