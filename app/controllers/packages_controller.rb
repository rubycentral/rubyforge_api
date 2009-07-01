class PackagesController < ApplicationController
  
  def index
    respond_to do |wants| 
      wants.js {render :json => group.packages.to_json }
    end
  end
  
  def create
    ensure_has_package_create || access_denied
    @package = group.packages.create!(params[:package])
    respond_to do |wants| 
      wants.js {render :json => @package, :status => :created, :location => group_package_url(group, @package)}
    end
  end
  
  def destroy
    ensure_has_package_create || access_denied
    group.packages.find_by_package_id(params[:id]).destroy
    head :success
  end

end
