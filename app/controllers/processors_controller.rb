class ProcessorsController < ApplicationController
  
  def index
    respond_to do |wants|
      wants.js {render :json => Processor.all}
    end
  end
end