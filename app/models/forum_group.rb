class ForumGroup < ActiveRecord::Base
  set_table_name "forum_group_list"
  set_primary_key "group_forum_id"
  belongs_to :group
  has_one :forum, :foreign_key => "group_forum_id"
end

