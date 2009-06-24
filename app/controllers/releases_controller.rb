class ReleasesController < ApplicationController

  def index
    respond_to do |wants| 
      wants.js {render :json => package.releases.map(&:externalize).to_json}
    end
  end

end
