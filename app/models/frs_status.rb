# == Schema Information
# Schema version: 20090605012055
#
# Table name: frs_status
#
#  status_id :integer         not null
#  name      :text
#

class FrsStatus < ActiveRecord::Base

  set_table_name 'frs_status'
  
  ACTIVE = 1
  HIDDEN = 3

  def self.add(id, name)
    ActiveRecord::Base.connection.execute "insert into frs_status values ('#{id}', '#{name}')"
  end

end
