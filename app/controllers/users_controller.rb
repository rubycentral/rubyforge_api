class UsersController < ApplicationController

  def show
    respond_to do |wants| 
      wants.js {render :json => user.to_json(:except => [:unix_pw, :email, :user_pw, :confirm_hash]) }
    end
  end
  
  def groups
    respond_to do |wants|
      wants.js {render :json => user.groups.active }
    end
  end
  
end
