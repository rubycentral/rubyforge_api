class GroupsController < ApplicationController

  def show
    respond_to do |wants| 
      wants.js {render :json => group.to_json }
    end
  end

end
