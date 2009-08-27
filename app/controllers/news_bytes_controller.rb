class NewsBytesController < ApplicationController
  
  before_filter :require_group_admin
  
  def create
    Group.transaction do
      @news_byte_forum = Group.system_news_group.forum_group.create!(:is_public => 1, :forum_name => params[:news_byte][:summary].parameterize[0..20], :description => params[:news_byte][:summary], :allow_anonymous => 0)
      @news_byte = group.news_bytes.create!(params[:news_byte].merge(:forum_id => @news_byte_forum.id, :submitted_by => current_user))
    end
    respond_to do |wants| 
      wants.js {render :json => @news_byte, :status => :created, :location => news_byte_url(@news_byte)}
    end
  end
  
end