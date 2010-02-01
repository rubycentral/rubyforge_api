# == Schema Information
# Schema version: 20090605012055
#
# Table name: news_bytes
#
#  id           :integer         not null, primary key
#  group_id     :integer         default(0), not null
#  submitted_by :integer         default(0), not null
#  is_approved  :integer         default(0), not null
#  post_date    :integer         default(0), not null
#  forum_id     :integer         default(0), not null
#  summary      :text
#  details      :text
#

class NewsByte < ActiveRecord::Base
  
  belongs_to :group
  belongs_to :forum_group, :foreign_key => 'forum_id', :dependent => :destroy
  belongs_to :submitted_by, :class_name => 'User', :foreign_key => 'submitted_by'

  named_scope :pending_approval, :conditions => {:is_approved => 0}

  def before_validation_on_create
    self.post_date = Time.now.to_i unless self.post_date && self.post_date != 0
  end
  
  def approve!
    self.is_approved = 1
    self.details = "(none)" if details.blank?
    self.summary = "(none)" if summary.blank?
    self.save!
  end
  
end
