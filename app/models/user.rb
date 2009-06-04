class User < ActiveRecord::Base
  set_primary_key "user_id"
  has_many :user_group
  has_many :groups, :through => :user_group
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

