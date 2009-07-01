class ReleasesController < ApplicationController

  def index
    respond_to do |wants| 
      # FIXME - don't show hidden releases if user is not a member of this project
      wants.js {render :json => package.releases.map(&:externalize).to_json}
    end
  end
  
  def create
    ensure_has_package_create || access_denied
    @release = group.packages.find_by_package_id(params[:package_id]).releases.create!(params[:release].merge({:released_by => current_user, :status_id => FrsStatus::ACTIVE}))
    respond_to do |wants| 
      wants.js {render :json => @release.externalize, :status => :created, :location => group_package_release_url(group, package, @release)}
    end
  end
  
end
