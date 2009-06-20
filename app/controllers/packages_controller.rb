class PackagesController < ApplicationController
  
  def create
    ensure_has_package_create || access_denied
    group.packages.create!(params[:package])
    head :created
  end
  
  protected
  
  # TODO this raises an exception instead of returning a client error if the user isn't a member of that group
  def ensure_has_package_create
    current_user.user_group.find_by_group_id(group.id).has_release_permissions?
  end
  
end
