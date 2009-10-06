class SnippetVersion < ActiveRecord::Base
  set_table_name 'snippet_version'
  set_primary_key 'snippet_version_id'
  
  belongs_to :snippet
  belongs_to :user, :foreign_key => 'submitted_by'
  has_many :snippet_package_items
  
end
