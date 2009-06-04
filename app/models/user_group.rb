class UserGroup < ActiveRecord::Base
  set_table_name "user_group"
  belongs_to :user
  belongs_to :group
end

