# == Schema Information
# Schema version: 20090605012055
#
# Table name: snippet
#
#  snippet_id  :integer         not null, primary key
#  created_by  :integer         default(0), not null
#  name        :text
#  description :text
#  type        :integer         default(0), not null
#  language    :integer         default(0), not null
#  license     :text            default(""), not null
#  category    :integer         default(0), not null
#

class Snippet < ActiveRecord::Base
  
  set_table_name 'snippet'
  set_primary_key 'snippet_id'
  
  belongs_to :user, :foreign_key => 'created_by'
  has_many :snippet_versions

  def self.inheritance_column
    nil
  end

  def snippet_type
    self[:type]
  end

  def snippet_type=(s)
    self[:type] = s
  end

end
