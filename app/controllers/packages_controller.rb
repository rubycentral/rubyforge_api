class PackagesController < ApplicationController
  
  def index
    respond_to do |wants| 
      wants.js {render :json => group.packages.to_json }
    end
  end
  
  def create
    ensure_has_package_create || access_denied
    group.packages.create!(params[:package])
    head :created
  end
  
  def destroy
    ensure_has_package_create || access_denied
    group.packages.find_by_package_id(params[:id]).destroy
    head :success
  end

end
