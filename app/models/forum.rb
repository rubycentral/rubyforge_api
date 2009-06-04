class Forum < ActiveRecord::Base
  set_table_name "forum"
  set_primary_key "msg_id"
  def delete_all_messages
    sql = "delete from forum where group_forum_id = #{self.group_forum_id}"
    puts "Running '#{sql}'..."
    Forum.connection.execute(sql)
  end
end

