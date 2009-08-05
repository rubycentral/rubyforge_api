class ReleasesController < ApplicationController

  before_filter :require_group_package_create, :only => [:create]

  def index
    respond_to do |wants| 
      # FIXME - don't show hidden releases if user is not a member of this project
      # TODO - replace this externalize thing with to_json parameters.  It's trick since we don't want to return the full
      # released_by object, e.g., the User along with email and password
      wants.js {render :json => package.releases.map(&:externalize).to_json}
    end
  end
  
  def create
    release_params = params[:release].merge({:released_by => current_user})
    release_params[:release_date] = Time.parse(release_params[:release_date])
    @release = group.packages.find_by_package_id(params[:package_id]).releases.create!(release_params)
    respond_to do |wants| 
      wants.js {render :json => @release.externalize, :status => :created, :location => group_package_release_url(group, package, @release)}
    end
  end
  
end
