# == Schema Information
# Schema version: 20090605012055
#
# Table name: mail_group_list
#
#  group_list_id :integer         not null
#  group_id      :integer         default(0), not null
#  list_name     :text
#  is_public     :integer         default(0), not null
#  password      :string(16)
#  list_admin    :integer         default(0), not null
#  status        :integer         default(0), not null
#  description   :text
#

class MailingList < ActiveRecord::Base
  set_table_name "mail_group_list"
  belongs_to :owner, :class_name => "User", :foreign_key => "list_admin"
  named_scope :not_created, :conditions => "status != 2"
  named_scope :deleted, :conditions => {:is_public => 9}
  def self.mailman_list_lists
    system("/var/mailman/bin/list_lists -b > /tmp/list_lists")
    File.read("/tmp/list_lists").split("\n")
  end
  def self.hourly_cron
    list_lists_cache = self.mailman_list_lists
    not_created.each do |mailing_list|
      if !mailing_list.is_deleted? && !list_lists_cache.include?(mailing_list.list_name)
        puts "Creating a new mailing list: #{mailing_list.list_name}"
        sql = "update mail_group_list set status = 2 where list_name = '#{mailing_list.list_name}'"
        puts sql
        ActiveRecord::Base.connection.execute sql
        cmd = "/var/mailman/bin/newlist #{mailing_list.list_name} #{mailing_list.owner.email} #{mailing_list.password} > /dev/null"
        puts cmd
        puts `#{cmd}`
        puts "Done"
      end
    end
    deleted.each do |mailing_list|
      if list_lists_cache.include?(mailing_list.list_name)
        puts "Need to delete mailing list using command:\n sudo /var/mailman/bin/rmlist -a #{mailing_list.list_name}\n"
      end
    end
  end
  def is_deleted?
    is_public == 9
  end
end
