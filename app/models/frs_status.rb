class FrsStatus < ActiveRecord::Base

  set_table_name 'frs_status'

  def self.add(id, name)
    ActiveRecord::Base.connection.execute "insert into frs_status values ('#{id}', '#{name}')"
  end

end