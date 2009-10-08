class DailyReport < ActionMailer::Base
  
  def summary_for(date)
    recipients "tom@infoether.com"
    from "noreply@rubyforge.org"
    subject "Daily summary for #{date}"
    datetime = date.to_datetime
    beginning_of_date_integer = datetime.beginning_of_day.to_time.to_i
    end_of_day_integer = datetime.end_of_day.to_time.to_i
    todays_groups = Group.find(:all, :conditions => {:register_time => beginning_of_date_integer..end_of_day_integer})
    todays_forum_messages = Forum.find(:all, :conditions => {:post_date => beginning_of_date_integer..end_of_day_integer}).reject {|m| m.posted_by.user_id == 102}
    todays_opened_artifacts = Artifact.find(:all, :conditions => {:open_date => beginning_of_date_integer..end_of_day_integer})
    todays_released_files = FrsFile.find(:all, :conditions => {:post_date => beginning_of_date_integer..end_of_day_integer})
    body :date => date, :todays_groups => todays_groups, :todays_forum_messages => todays_forum_messages, :todays_opened_artifacts => todays_opened_artifacts, :todays_released_files => todays_released_files
  end
  
end
