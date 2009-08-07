# == Schema Information
# Schema version: 20090605012055
#
# Table name: snippet_package
#
#  snippet_package_id :integer         not null, primary key
#  created_by         :integer         default(0), not null
#  name               :text
#  description        :text
#  category           :integer         default(0), not null
#  language           :integer         default(0), not null
#

class SnippetPackage < ActiveRecord::Base
  set_table_name 'snippet_package'
  set_primary_key 'snippet_package_id'
  belongs_to :user, :foreign_key => 'created_by'
end
