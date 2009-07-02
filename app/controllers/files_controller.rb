class FilesController < ApplicationController
  
  before_filter :require_group_package_create
  
  def create
    release = group.packages.find_by_package_id(params[:package_id]).releases.find_by_release_id(params[:release_id])
    group.verify_existence_of_gforge_file_directory!
    contents = params.delete(:contents)
    filename = params[:file][:filename]
    File.open(File.join(group.group_file_directory, filename), "w") do |f|
      f.syswrite contents
    end
    release.files.create!(params[:file].merge({:file_size => File.size(File.join(group.group_file_directory, filename))}))
    head :created
  end
  
end