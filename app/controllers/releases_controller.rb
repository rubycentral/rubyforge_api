class ReleasesController < ApplicationController

  def index
    respond_to do |wants| 
      # FIXME - don't show hidden releases if user is not a member of this project
      wants.js {render :json => package.releases.map(&:externalize).to_json}
    end
  end
  
end
