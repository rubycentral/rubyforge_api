# == Schema Information
# Schema version: 20090605012055
#
# Table name: frs_file
#
#  file_id      :integer         not null, primary key
#  filename     :text
#  release_id   :integer         default(0), not null
#  type_id      :integer         default(0), not null
#  processor_id :integer         default(0), not null
#  release_time :integer         default(0), not null
#  file_size    :integer         default(0), not null
#  post_date    :integer         default(0), not null
#

class FrsFile < ActiveRecord::Base

  set_primary_key "file_id"
  set_table_name "frs_file"
  
  belongs_to :file_type, :foreign_key => 'type_id'
  belongs_to :processor
  belongs_to :release
  
  before_validation_on_create :set_defaults

  def hours_old
    (Time.now.to_i - release_time)/3600
  end

  private
  
  def set_defaults
    self.release_time = Time.now.to_i
    self.post_date = Time.now.to_i
  end
end

