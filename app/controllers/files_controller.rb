class FilesController < ApplicationController
  
  before_filter :require_group_package_create_authorization, :only => :create

  def index
    respond_to do |wants|
      wants.js { render :json => release.files.to_json }
    end
  end
  
  def create
    group.verify_existence_of_gforge_file_directory!
    contents = params.delete(:contents)
    filename = params[:file][:filename]
    File.open(File.join(group.group_file_directory, filename), "w") do |f|
      f.syswrite contents
    end
    release.files.create!(params[:file].merge({:file_size => File.size(File.join(group.group_file_directory, filename))}))
    head :created
  end

  def require_group_package_create_authorization
    access_denied unless current_user.member_of_group?(group) && current_user.user_group.find_by_group_id(group.id).has_release_permissions?
  end
  
  private 
  
  def release
    @release ||= Release.find(params[:release_id])
  end
  
  def group
    @group ||= release.package.group
  end
  
end