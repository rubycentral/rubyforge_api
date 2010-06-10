namespace :rubyforge do
  desc "Collects disk usage numbers"
  task :collect_disk_usage => :environment do
    Group.active.each do |g|
      g.disk_usages.create(:released_files_space_used => g.release_files_space_usage, :scm_space_used => g.scm_disk_space_usage, :virtual_host_space_used => g.virtual_host_space_usage)
      sleep 2
    end
  end
  
  desc "Sends daily activity report"
  task :send_daily_activity_report => :environment do
    DailyReport.deliver_summary_for(Time.now.to_date)
  end
  
  desc "Approve all pending news bytes"
  task :approve_news => :environment do
    NewsByte.pending_approval.each do |news_byte|
      news_byte.approve! unless news_byte.summary =~ /Commit Notification/
    end
  end

end

def get_name_from_script(long_name)
  names = long_name.split(/-[0-9]/)
  names.size > 1 ? names[0] : nil
end
