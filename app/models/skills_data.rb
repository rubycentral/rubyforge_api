class SkillsData < ActiveRecord::Base
  
  self.inheritance_column = :__type_disabled__
   
  set_table_name "skills_data"
  set_primary_key "skills_data_id"
  
  belongs_to :user
  
  def self.remove_spam!
    words = %w{nike ophthalmologist Battery handbags Swimming Advertising porn ringtones shoes wrestling dating href HREF herf watches blackjack poker Casino affiliate}
    words << "url="
    words << "ralph lauren"
    words << "certified nursing assistant"
    words << "Technology can also be my thing"
    words << "furnace repair"
    words << "Thanks for the great content"
    words.each do |term|
      find(:all, :conditions => "keywords ilike '%#{term}%'").each do |s| 
        s.user.mark_as_deleted!
        s.destroy
      end
    end
  end
  
end