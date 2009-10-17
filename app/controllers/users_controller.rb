class UsersController < ApplicationController

  def show
    respond_to do |wants| 
      wants.js {render :json => user }
    end
  end
  
  def groups
    respond_to do |wants|
      wants.js {render :json => user.groups.active }
    end
  end
  
end
