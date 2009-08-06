class GroupsController < ApplicationController

  def show
    respond_to do |wants| 
      wants.js {render :json => group }
    end
  end
  
  def index
    respond_to do |wants|
      wants.js {render :json => (user || current_user).groups.active }
    end
  end
  
end
