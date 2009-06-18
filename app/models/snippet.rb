class Snippet < ActiveRecord::Base
  set_table_name 'snippet'
  set_primary_key 'snippet_id'
  belongs_to :user, :foreign_key => 'created_by'

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
