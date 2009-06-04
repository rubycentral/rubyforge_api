# == Schema Information
#
# Table name: plugins
#
#  plugin_id   :integer         not null, primary key
#  plugin_name :string(32)      not null
#  plugin_desc :text
#

class Plugin < ActiveRecord::Base
  set_primary_key "plugin_id"
  has_and_belongs_to_many :groups, :join_table => "group_plugin"
end

