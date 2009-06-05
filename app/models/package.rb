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
  
  validates_presence_of :group_id, :name
  validates_inclusion_of :status_id, :in => [1,3]
  validates_uniqueness_of :name, :scope => :group_id
  validates_associated :group

  def before_validation_on_create
    self.status_id = 1 unless self.status_id && self.status_id != 0
  end
end
