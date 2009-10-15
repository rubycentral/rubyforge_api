class StatusController < ApplicationController
  
  skip_before_filter :require_logged_in, :require_not_overeager
  skip_filter :record_api_request
  
  def status
    head :ok
  end
  
end
