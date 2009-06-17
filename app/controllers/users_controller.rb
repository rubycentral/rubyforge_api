class UsersController < ApplicationController

  def show
    respond_to do |wants| 
      wants.js {render :json => user.externalize.to_json }
    end
  end

  protected
  
  def user
    @user ||= if params[:id] =~ /^\d+$/
      User.find params[:id]
    else
      User.find_by_user_name params[:id] 
    end
  end
  
  
end
