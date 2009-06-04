class PackagesController < ApplicationController
  
  before_filter :authenticate, :only => [:create]

  def create
    ensure_has_package_create || access_denied
  end
  
  protected
  
  def group
    @group ||= Group.find(params[:group_id])
  end
  
  def ensure_has_package_create
    current_user.user_group.find_by_group_id(group.id).has_release_permissions?
  end
  
  def current_user
    @current_user
  end
  
  def authenticate
    @current_user = User.authentication(params[:username], params[:password])
    raise "Authentication failed" unless @current_user
  end

end
