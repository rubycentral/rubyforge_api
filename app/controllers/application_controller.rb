class ApplicationController < ActionController::Base
  
  helper :all 
  filter_parameter_logging :password, :contents

  before_filter :require_logged_in, :require_not_overeager
  around_filter :record_api_request

  include ExceptionNotifiable

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
    current_user.api_requests.count_recent > 3600
  end

  # TODO do some meta-programmer thing to reduce this duplication
  def group
    group_id = params[:group_id] || params[:id]
    @group ||= if group_id =~ /^\d+$/
      Group.find group_id
    else
      Group.find_by_unix_group_name group_id
    end
  end
  
  def user
    user_id = params[:user_id] || params[:id]
    @user ||= if user_id =~ /^\d+$/
      User.find user_id
    else
      User.find_by_user_name user_id
    end
  end
  
  def package
    @package ||= Package.find(params[:package_id] || params[:id])
  end
  
  def require_logged_in
    unauthorized unless current_user
  end
  
  def require_not_overeager
    access_denied if current_user_too_eager
  end
  
  def require_group_package_create_authorization(g = group)
    access_denied unless current_user.member_of_group?(g) && current_user.user_group.find_by_group_id(g.id).has_release_permissions?
  end
  
  def require_group_admin
    access_denied unless current_user.member_of_group?(group) && current_user.user_group.find_by_group_id(group.id).group_admin?
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
