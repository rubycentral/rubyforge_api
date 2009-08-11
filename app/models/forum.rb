# == Schema Information
# Schema version: 20090605012055
#
# Table name: forum
#
#  msg_id           :integer         not null, primary key
#  group_forum_id   :integer         default(0), not null
#  posted_by        :integer         default(0), not null
#  subject          :text            default(""), not null
#  body             :text            default(""), not null
#  post_date        :integer         default(0), not null
#  is_followup_to   :integer         default(0), not null
#  thread_id        :integer         default(0), not null
#  has_followups    :integer         default(0)
#  most_recent_date :integer         default(0), not null
#

class Forum < ActiveRecord::Base

  set_table_name "forum"
  set_primary_key "msg_id"
  
  belongs_to :forum_group, :class_name => 'ForumGroup', :foreign_key => 'group_forum_id'
  belongs_to :posted_by, :class_name => 'User', :foreign_key => 'posted_by'

  def delete_all_messages
    sql = "delete from forum where group_forum_id = #{self.group_forum_id}"
    puts "Running '#{sql}'..."
    Forum.connection.execute(sql)
  end
end

