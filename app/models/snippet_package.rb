class SnippetPackage < ActiveRecord::Base
  set_table_name 'snippet_package'
  set_primary_key 'snippet_package_id'
  belongs_to :user, :foreign_key => 'created_by'
end
