class ApplicationController < ActionController::Base
  
  helper :all 
  filter_parameter_logging :password

  before_filter :require_not_overeager
  before_filter :require_logged_in
  around_filter :record_api_request

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
  
  def current_user_too_eager
    current_user.api_requests.count_recent > 60
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
  
  def require_logged_in
    unauthorized unless current_user
  end
  
  def require_not_overeager
    access_denied if current_user_too_eager
  end
  
  def require_group_package_create
    access_denied unless current_user.user_group.find_by_group_id(group.id).has_release_permissions?
  end

  def require_group_admin
    access_denied unless current_user.user_group.find_by_group_id(group.id).group_admin?
  end
  
  # see http://www.codyfauser.com/2008/7/4/rails-http-status-code-to-symbol-mapping
  # also, the spec: http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
  def unauthorized
    render :text => "Unauthorized", :content_type => "text/plain", :status => :unauthorized
  end

  def access_denied
    render :text => "Access denied", :content_type => "text/plain", :status => :forbidden
  end
  
end
