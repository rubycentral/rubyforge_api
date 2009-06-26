class ApplicationController < ActionController::Base
  
  helper :all 
  filter_parameter_logging :password

  before_filter :ensure_not_overeager
  before_filter :ensure_logged_in
  around_filter :record_api_request

  def ensure_logged_in
    access_denied unless current_user
  end
  
  def current_user
    @current_user ||= authenticate_or_request_with_http_basic("RubyForge API") do |username, password|
      User.authenticate(username, password)
    end
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

  def access_denied
    head :unauthorized
  end
  
  def group
    @group ||= if (params[:group_id] || params[:id]) =~ /^\d+$/
      Group.find(params[:group_id] || params[:id])
    else
      Group.find_by_unix_group_name(params[:group_id] || params[:id])
    end
  end
  
  def package
    @package ||= Package.find(params[:package_id])
  end
  
  # TODO this raises an exception instead of returning a client error if the user isn't a member of that group
  def ensure_has_package_create
    current_user.user_group.find_by_group_id(group.id).has_release_permissions?
  end
  
end
