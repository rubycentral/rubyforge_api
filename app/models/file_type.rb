class FileType < ActiveRecord::Base

  set_table_name 'frs_filetype'
  set_primary_key 'type_id'

  def self.add(type_id, name)
    ActiveRecord::Base.connection.execute "insert into frs_filetype values ('#{type_id}', '#{name}')"
  end

end