# == Schema Information
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

  def hours_old
    (Time.now.to_i - release_time)/3600
  end

end

