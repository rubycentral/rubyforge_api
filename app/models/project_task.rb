class ProjectTask < ActiveRecord::Base
  
  set_table_name 'project_task'
  set_primary_key 'project_task_id'

  has_many :project_messages
end