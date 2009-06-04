class FrsFile < ActiveRecord::Base
  set_primary_key "file_id"
  set_table_name "frs_file"
  def hours_old
    (Time.now.to_i - release_time)/3600
  end
end

