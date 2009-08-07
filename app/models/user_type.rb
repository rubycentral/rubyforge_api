# == Schema Information
# Schema version: 20090605012055
#
# Table name: user_type
#
#  type_id   :integer         not null, primary key
#  type_name :text
#

class UserType < ActiveRecord::Base
  set_table_name 'user_type'
  set_primary_key 'type_id'
end
