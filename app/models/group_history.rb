# == Schema Information
#
# Table name: group_history
#
#  group_history_id :integer         not null, primary key
#  group_id         :integer         default(0), not null
#  field_name       :text            default(""), not null
#  old_value        :text            default(""), not null
#  mod_by           :integer         default(0), not null
#  adddate          :integer
#

class GroupHistory < ActiveRecord::Base
  set_primary_key "group_history_id"
  set_table_name "group_history"
end

