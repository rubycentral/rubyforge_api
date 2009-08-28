class Mirror < ActiveRecord::Base

  named_scope :enabled, :conditions => {:enabled => true}
  
  validates_format_of :url, :with => /^http/
  
  def disable!
    self.enabled = false
    save!
  end
  
  def enable!
    self.enabled = true
    save!
  end
  
end
