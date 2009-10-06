class SnippetPackageItem < ActiveRecord::Base

  set_table_name 'snippet_package_item'
  set_primary_key 'snippet_package_item_id'
  
  belongs_to :snippet_package_version
  belongs_to :snippet_version
end
