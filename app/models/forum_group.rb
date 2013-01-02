# == Schema Information
# Schema version: 20090605012055
#
# Table name: forum_group_list
#
#  group_forum_id    :integer         not null, primary key
#  group_id          :integer         default(0), not null
#  forum_name        :text            default(""), not null
#  is_public         :integer         default(0), not null
#  description       :text
#  allow_anonymous   :integer         default(0), not null
#  send_all_posts_to :text
#

class ForumGroup < ActiveRecord::Base

  set_table_name "forum_group_list"
  set_primary_key "group_forum_id"

  belongs_to :group
  has_many :forums, :foreign_key => "group_forum_id"

  def disallow_anonymous_postings!
    self.update_attribute :allow_anonymous, false
  end

end

