class SkillsData < ActiveRecord::Base
  
  self.inheritance_column = :__type_disabled__
   
  set_table_name "skills_data"
  set_primary_key "skills_data_id"
  
  belongs_to :user
  
end