class Plugin < ActiveRecord::Base
  set_primary_key "plugin_id"
  has_and_belongs_to_many :groups, :join_table => "group_plugin"
end

