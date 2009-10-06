namespace :rubyforge do
  desc "Collects disk usage numbers"
  task :collect_disk_usage => :environment do
    Group.active.each do |g|
      g.disk_usages.create(:released_files_space_used => g.release_files_space_usage, :scm_space_used => g.scm_disk_space_usage, :virtual_host_space_used => g.virtual_host_space_usage)
      sleep 2
    end
  end
  
  desc "Reloads gem namespace map"
  task :reload_gem_namespace_map => :environment do
    GemNamespaceOwnership.transaction do
      GemNamespaceOwnership.delete_all
      Marshal.load(File.read(ENV["MAP_FILE"])).each do |gem_name, unix_group_name|
        if !Group.exists?(:unix_group_name => unix_group_name)
          Rails.logger.info "Skipping #{unix_group_name} owns #{gem_name} since #{unix_group_name} doesn't exist"
          next
        end  
        namespace = get_name_from_script(gem_name)
        if namespace.blank?
          Rails.logger.info "Skipping #{unix_group_name} owns #{gem_name} since '#{gem_name}' is blank"
          next
        end
        group = Group.find_by_unix_group_name(unix_group_name)
        if GemNamespaceOwnership.exists?(:group_id => group.id, :namespace => namespace)
          Rails.logger.info "Skipping #{unix_group_name} owns #{gem_name} since #{gem_name} is already claimed by #{unix_group_name}"
          next
        end
        Rails.logger.info "Creating GemNamespaceOwnership for #{unix_group_name} owns #{gem_name}"
        GemNamespaceOwnership.create!(:group => group, :namespace => namespace)
      end
    end
  end
  
  desc "Sends daily activity report"
  task :send_daily_activity_report => :environment do
    DailyReport.deliver_summary_for(Time.now)
  end

end

def get_name_from_script(long_name)
  names = long_name.split(/-[0-9]/)
  names.size > 1 ? names[0] : nil
end
