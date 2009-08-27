class PackagesController < ApplicationController
  
  before_filter :require_group_package_create_authorization, :only => :create
  before_filter :require_package_destroy_authorization, :only => :destroy
  
  def index
    respond_to do |wants| 
      wants.js {render :json => group.packages }
    end
  end
  
  def create
    @package = group.packages.create!(params[:package])
    respond_to do |wants| 
      wants.js {render :json => @package, :status => :created, :location => package_url(@package)}
    end
  end
  
  def destroy
    package.destroy
    head :accepted
  end
  
  def require_package_destroy_authorization
    require_group_package_create_authorization(package.group)
  end
  
end
