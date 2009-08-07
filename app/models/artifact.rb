# == Schema Information
# Schema version: 20090605012055
#
# Table name: artifact
#
#  artifact_id       :integer         not null, primary key
#  group_artifact_id :integer         not null
#  status_id         :integer         default(1), not null
#  category_id       :integer         default(100), not null
#  artifact_group_id :integer         default(0), not null
#  resolution_id     :integer         default(100), not null
#  priority          :integer         default(3), not null
#  submitted_by      :integer         default(100), not null
#  assigned_to       :integer         default(100), not null
#  open_date         :integer         default(0), not null
#  close_date        :integer         default(0), not null
#  summary           :text            not null
#  details           :text            not null
#

class Artifact < ActiveRecord::Base
  
  set_table_name 'artifact'
  set_primary_key 'artifact_id'
  
  has_many :artifact_messages, :dependent => :destroy
  has_many :artifact_histories, :dependent => :destroy
  has_many :artifact_files, :dependent => :destroy
  belongs_to :artifact_group_list, :foreign_key => 'group_artifact_id'
  belongs_to :submitted_by, :class_name => 'User', :foreign_key => 'submitted_by'
  
end
