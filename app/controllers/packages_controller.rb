class PackagesController < ApplicationController
  
  before_filter :ensure_logged_in, :only => [:create]
  around_filter :record_api_request
  before_filter :ensure_not_overeager

  def create
    ensure_has_package_create || access_denied
    group.packages.create(params[:package])
    head :created
  end
  
  protected
  
  def access_denied
    head :unauthorized
  end
  
  # Most of these methods will probably move over to ApplicationController; just keeping them here now for convenience
  def group
    @group ||= Group.find(params[:group_id])
  end
  
  def ensure_logged_in
    access_denied unless current_user
  end
  
  # TODO this raises an exception instead of returning a client error if the user isn't a member of that group
  def ensure_has_package_create
    current_user.user_group.find_by_group_id(group.id).has_release_permissions?
  end
  
  def current_user
    @current_user ||= User.authenticate(params[:username], params[:password])
  end
  
  def record_api_request
    yield
  ensure
    ApiRequest.create(:user => current_user, :path => request.path, :method => request.method.to_s.upcase, :ip_address => request.remote_ip, :response_code => response.status)
  end
  
  def ensure_not_overeager
    access_denied if current_user_too_eager
  end
  
  def current_user_too_eager
    current_user.api_requests.count_recent > 60
  end

end
