namespace :rubyforge do
  desc "Collects disk usage numbers"
  task :collect_disk_usage do
    Group.active.each do |g|
      g.disk_usages.create(:released_files_space_used => g.release_files_space_usage, :scm_space_used => g.scm_disk_space_usage, :virtual_host_space_used => g.virtual_host_space_usage)
    end
  end
end