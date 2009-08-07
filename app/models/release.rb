# == Schema Information
# Schema version: 20090605012055
#
# Table name: frs_release
#
#  release_id   :integer         not null, primary key
#  package_id   :integer         default(0), not null
#  name         :text
#  notes        :text
#  changes      :text
#  status_id    :integer         default(0), not null
#  preformatted :integer         default(0), not null
#  release_date :integer         default(0), not null
#  released_by  :integer         default(0), not null
#

class Release < ActiveRecord::Base
  
  set_table_name 'frs_release'
  set_primary_key 'release_id'

  belongs_to :package
  belongs_to :released_by, :class_name => 'User', :foreign_key => 'released_by'
  has_many :files, :class_name => 'FrsFile', :dependent => :destroy
  
  before_validation_on_create :set_defaults
  
  # TODO replace this with to_json - but without returning the released_by user's unix_pw etc
  def externalize
    self.attributes.inject({}) do |memo, a| 
      if a[0] == "release_date"
        memo[a[0]] = Time.at(a[1]).to_s(:db)
      else
        memo[a[0]] = a[1]
      end
      memo
    end
  end
  
  private
  
  def set_defaults
    self.release_date = Time.now.to_i unless self.release_date && self.release_date != 0
    self.status_id = FrsStatus::ACTIVE unless self.status_id && self.status_id != 0
  end
end
