class MirrorsController < ApplicationController
  
  def index
    respond_to do |wants| 
      wants.js do
        # Is there a nicer way to do to_json with collections and :except?
        render :text => "[ %s ]" % Mirror.enabled.collect {|m| m.to_json(:except => [:id, :administrator_email, :enabled])}.join(","),:content_type => 'application/json' 
      end
    end
  end
  
end
