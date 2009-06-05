# == Schema Information
#
# Table name: users
#
#  user_id            :integer         not null, primary key
#  user_name          :text            default(""), not null
#  email              :text            default(""), not null
#  user_pw            :string(32)      default(""), not null
#  realname           :string(32)      default(""), not null
#  status             :string(1)       default("A"), not null
#  shell              :string(20)      default("/bin/bash"), not null
#  unix_pw            :string(40)      default(""), not null
#  unix_status        :string(1)       default("N"), not null
#  unix_uid           :integer         default(0), not null
#  unix_box           :string(10)      default("shell1"), not null
#  add_date           :integer         default(0), not null
#  confirm_hash       :string(32)
#  mail_siteupdates   :integer         default(0), not null
#  mail_va            :integer         default(0), not null
#  authorized_keys    :text
#  email_new          :text
#  people_view_skills :integer         default(0), not null
#  people_resume      :text            default(""), not null
#  timezone           :string(64)      default("GMT")
#  language           :integer         default(1), not null
#  block_ratings      :integer         default(0)
#  jabber_address     :text
#  jabber_only        :integer
#  address            :text
#  phone              :text
#  fax                :text
#  title              :text
#  theme_id           :integer
#  firstname          :string(60)
#  lastname           :string(60)
#  address2           :text
#  ccode              :string(2)       default("US")
#  sys_state          :string(1)       default("N")
#  type_id            :integer         default(1)
#

class User < ActiveRecord::Base
  
  set_primary_key "user_id"
  has_many :user_group
  has_many :groups, :through => :user_group
  has_many :api_requests do
    def count_recent
      count(:all, :conditions => "created_at > '#{Time.now - 1.hour}'")
    end
  end
  has_many :forum_messages, :class_name => "Forum", :foreign_key => "posted_by"
  named_scope :active, :conditions => {:status => "A"}
  named_scope :with_uploaded_keys, :conditions => "authorized_keys is not null and authorized_keys != ''"
  # This is not correct yet... needs a HAVING clause, I think
  named_scope :with_scm_write_to_at_least_one_project, :conditions => "users.user_id = user_group.user_id and cvs_flags = 1", :joins => :user_group
  
  def self.user_with_sorted_groups_hash
    # TODO should use the PostgreSQL equivalent of MySQL's group_concat
    sql = "select u.user_name, g.unix_group_name from users u, user_group ug, groups g where u.user_id = ug.user_id and ug.group_id = g.group_id and ug.cvs_flags = '1' and u.status='A' and g.status = 'A' order by u.user_name"
    hash = {}
    ActiveRecord::Base.connection.query(sql).each do |rec|
      hash[rec[0]] ||= []
      hash[rec[0]] << rec[1] unless rec[1] == "sourceforge"
    end
    hash.each {|k,v| hash[k] = v.sort }
    hash
  end
  
  def self.authenticate(username, clear_text_password)
    User.find_by_user_name_and_user_pw(username, Digest::MD5.hexdigest(clear_text_password))
  end
  
  def authorized_keys_with_newlines
    authorized_keys.gsub("###", "\n")
  end
  def unix_forward_file_path
    "#{home_directory}/.forward"
  end
  def unix_authorized_keys_file_path
    "#{dot_ssh_directory}/authorized_keys"
  end
  def dot_ssh_directory
    "#{home_directory}/.ssh"
  end
  def password
    unix_pw
  end
  def home_directory
    "/home/#{user_name}"
  end
end

