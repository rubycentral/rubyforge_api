class Release < ActiveRecord::Base
  
  set_table_name 'frs_release'
  set_primary_key 'release_id'

  belongs_to :package
  belongs_to :released_by, :class_name => 'User', :foreign_key => 'released_by'
  has_many :files, :class_name => 'FrsFile', :dependent => :destroy
  
  before_validation_on_create :set_defaults
  
  def externalize
    self.attributes.inject({}) do |memo, a| 
      memo[a[0]] = a[1]
      memo
    end
  end
  
  private
  
  def set_defaults
    self.release_date = Time.now.to_i 
    self.status_id = FrsStatus::ACTIVE unless self.status_id && self.status_id != 0
  end
end