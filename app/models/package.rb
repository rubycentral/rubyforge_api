class Package < ActiveRecord::Base
  set_table_name 'frs_package'
  set_primary_key 'package_id'
  belongs_to :group
end
