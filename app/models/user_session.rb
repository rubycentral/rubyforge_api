class UserSession < ActiveRecord::Base

  set_table_name 'user_session'
  # TODO - can I add a primary key here without breaking GForge?
  
  def self.delete_all_for_user(user)
    ActiveRecord::Base.connection.execute "delete from user_session where user_id = #{user.id}"
  end
  
end
