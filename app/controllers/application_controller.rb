class ApplicationController < ActionController::Base
  helper :all 
  filter_parameter_logging :password
end
