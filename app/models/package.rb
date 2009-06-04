# == Schema Information
#
# Table name: frs_package
#
#  package_id :integer         not null, primary key
#  group_id   :integer         default(0), not null
#  name       :text
#  status_id  :integer         default(0), not null
#  is_public  :integer         default(1)
#

class Package < ActiveRecord::Base
  set_table_name 'frs_package'
  set_primary_key 'package_id'
  belongs_to :group
end
