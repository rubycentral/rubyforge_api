class PackagesController < ApplicationController
  
  before_filter :require_group_package_create, :only => [:create, :destroy]
  
  def index
    respond_to do |wants| 
      wants.js {render :json => group.packages.to_json }
    end
  end
  
  def create
    @package = group.packages.create!(params[:package])
    respond_to do |wants| 
      wants.js {render :json => @package, :status => :created, :location => group_package_url(group, @package)}
    end
  end
  
  def destroy
    group.packages.find_by_package_id(params[:id]).destroy
    head :success
  end

end
