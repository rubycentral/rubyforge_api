class NewsByte < ActiveRecord::Base
  
  belongs_to :group
  belongs_to :forum_group, :foreign_key => 'forum_id', :dependent => :destroy
  belongs_to :submitted_by, :class_name => 'User', :foreign_key => 'submitted_by'

  def before_validation_on_create
    self.post_date = Time.now.to_i unless self.post_date && self.post_date != 0
  end
  
end