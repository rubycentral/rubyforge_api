class SnippetPackageVersion < ActiveRecord::Base

  set_table_name 'snippet_package_version'
  set_primary_key 'snippet_package_version_id'
  
  belongs_to :snippet_package
  belongs_to :user, :foreign_key => 'submitted_by'
  
end
