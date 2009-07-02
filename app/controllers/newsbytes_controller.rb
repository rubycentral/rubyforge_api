class NewsBytesController < ApplicationController
  
  def create
    ensure_is_group_admin || access_denied
    Group.transaction do
      @news_byte_forum = Group.system_news_group.forum_group.create!(:is_public => 1, :forum_name => params[:news_byte][:summary].parameterize[0..20], :description => params[:news_byte][:summary], :allow_anonymous => 0)
      @news_byte = group.news_bytes.create!(params[:news_byte].merge(:forum_id => @news_byte_forum.id, :submitted_by => current_user))
    end
    respond_to do |wants| 
      wants.js {render :json => @news_byte, :status => :created, :location => group_news_byte_url(group, @news_byte)}
    end
  end
  
  private
  
  def ensure_is_group_admin
    current_user.user_group.find_by_group_id(group.id).group_admin?
  end
  
end