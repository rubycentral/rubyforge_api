class ProjectMessage < ActiveRecord::Base

  set_primary_key 'project_message_id'
  
  belongs_to :project_task
  
end