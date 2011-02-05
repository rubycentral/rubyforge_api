class SkillsData < ActiveRecord::Base
  
  self.inheritance_column = :__type_disabled__
   
  set_table_name "skills_data"
  set_primary_key "skills_data_id"
  
  belongs_to :user
  
  def self.remove_spam!
    %w{nike porn shoes wrestling dating href HREF herf watches blackjack poker}.each do |term|
      find(:all, :conditions => "keywords like '%#{term}%'").each do |s| 
        s.user.mark_as_deleted!
        s.destroy
      end
    end
  end
  
end