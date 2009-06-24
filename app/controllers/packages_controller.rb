class PackagesController < ApplicationController
  
  def index
    respond_to do |wants| 
      wants.js {render :json => group.packages.to_json }
    end
  end
  
  def create
    ensure_has_package_create || access_denied
    group.packages.create!(params[:package])
    head :created
  end
  
  def destroy
    ensure_has_package_create || access_denied
    group.packages.find_by_package_id(params[:id]).destroy
    head :success
  end

  protected
  
  # TODO this raises an exception instead of returning a client error if the user isn't a member of that group
  def ensure_has_package_create
    current_user.user_group.find_by_group_id(group.id).has_release_permissions?
  end
  
end
