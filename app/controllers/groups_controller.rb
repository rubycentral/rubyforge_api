class GroupsController < ApplicationController

  def show
    respond_to do |wants| 
      wants.js {render :json => group }
    end
  end
  
end
