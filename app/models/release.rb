class Release < ActiveRecord::Base
  set_table_name 'frs_release'
  set_primary_key 'release_id'
  belongs_to :package
  belongs_to :released_by, :class_name => 'User', :foreign_key => 'released_by'
  
  def externalize
    self.attributes.inject({}) do |memo, a| 
      if a[0] == "released_by"
        memo[a[0]] = a[1].id
      else
        memo[a[0]] = a[1]
      end
      memo
    end
  end
end