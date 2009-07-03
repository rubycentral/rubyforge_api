class UsersController < ApplicationController

  def show
    respond_to do |wants| 
      wants.js {render :json => user.to_json(:include => user.groups.active, :except => [:unix_pw, :email, :user_pw, :confirm_hash]) }
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
