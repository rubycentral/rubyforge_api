class Mirror < ActiveRecord::Base

  named_scope :enabled, :conditions => {:enabled => true}
  named_scope :serves_files, :conditions => {:serves_files => true}
  named_scope :serves_gems, :conditions => {:serves_files => false}
  
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
