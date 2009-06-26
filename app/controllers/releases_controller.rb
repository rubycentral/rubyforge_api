class ReleasesController < ApplicationController

  def index
    respond_to do |wants| 
      # FIXME - don't show hidden releases if user is not a member of this project
      wants.js {render :json => package.releases.map(&:externalize).to_json}
    end
  end
  
  def create
    ensure_has_package_create || access_denied
    group.packages.find_by_package_id(params[:package_id]).releases.create!(params[:release].merge({:released_by => current_user, :status_id => FrsStatus::ACTIVE}))
    head :created
  end
  
end
