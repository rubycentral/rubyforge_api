# == Schema Information
#
# Table name: groups
#
#  group_id                      :integer         not null, primary key
#  group_name                    :string(40)
#  homepage                      :string(128)
#  is_public                     :integer         default(0), not null
#  status                        :string(1)       default("A"), not null
#  unix_group_name               :string(30)      default(""), not null
#  unix_box                      :string(20)      default("shell1"), not null
#  http_domain                   :string(80)
#  short_description             :string(255)
#  register_purpose              :text
#  license_other                 :text
#  register_time                 :integer         default(0), not null
#  rand_hash                     :text
#  use_mail                      :integer         default(1), not null
#  use_survey                    :integer         default(1), not null
#  use_forum                     :integer         default(1), not null
#  use_pm                        :integer         default(1), not null
#  use_scm                       :integer         default(1), not null
#  use_news                      :integer         default(1), not null
#  type_id                       :integer         default(1), not null
#  use_docman                    :integer         default(1), not null
#  new_doc_address               :text            default(""), not null
#  send_all_docs                 :integer         default(0), not null
#  use_pm_depend_box             :integer         default(1), not null
#  use_ftp                       :integer         default(0)
#  use_tracker                   :integer         default(1)
#  use_frs                       :integer         default(1)
#  use_stats                     :integer         default(1)
#  enable_pserver                :integer         default(1)
#  enable_anonscm                :integer         default(1)
#  sys_state                     :string(1)       default("N")
#  license                       :integer         default(100)
#  scm_box                       :text
#  needs_vhost_permissions_reset :boolean
#

class Group < ActiveRecord::Base
  
  set_primary_key "group_id"
  
  has_and_belongs_to_many :plugins, :join_table => "group_plugin" do
    def includes_svn?
      !all.select {|p| p.plugin_name == "scmsvn"}.empty?
    end
    def includes_git?
      !all.select {|p| p.plugin_name == "scmgit"}.empty?
    end
    def includes_cvs?
      !all.select {|p| p.plugin_name == "scmcvs"}.empty?
    end
    def scm
      all.find {|p| p.plugin_name =~ /^scm/}
    end
  end
  has_many :group_histories
  has_many :user_group
  has_many :users, :through => :user_group
  has_many :forum_group
  has_many :forums, :through => :forum_group
  has_many :packages
  belongs_to :license, :foreign_key => 'license'
  
  named_scope :active, :conditions => {:status => 'A'}
  named_scope :pending, :conditions => {:status => 'P'}
  named_scope :needs_vhost_permissions_reset, :conditions => {:needs_vhost_permissions_reset => true}
  named_scope :uses_git, :conditions => "groups.group_id = group_plugin.group_id and group_plugin.plugin_id = plugins.plugin_id and plugins.plugin_name = 'scmgit'", :joins => ", plugins, group_plugin"
  
  def vhost_conf
    "#{HTTPD_CONF_DIR}#{unix_group_name}.rubyforge.org.conf"
  end
  def wiki_dir
    "#{WWW_DIR_PREFIX}#{unix_group_name}/wiki/"
  end
  def first_admin
    user_group.select {|ug| ug.admin_flags.strip == 'A' }.first.user
  end
  def provisioned?
    File.exists? vhost_root
  end
  def reset_vhost_permissions
    cmd = "chmod -R g+ws #{vhost_root}"
    puts "#{Time.now}: Running: #{cmd}"
    `#{cmd}`
  end
  def provision
    add_group_and_user
    provision_docroot
    if plugins.includes_svn? 
      svnify
    elsif plugins.includes_git?
      gitify
    else
      cvsify
    end
    provision_vhost
  end
  def add_group_and_user
    admin = first_admin.user_name
    `/usr/sbin/groupadd #{unix_group_name}`
    if !File.exists?("/home/#{admin}")  
      `/usr/sbin/useradd -g #{unix_group_name} -s /bin/cvssh #{admin}`
      cmd = "echo '#{first_admin.email}' > /home/#{admin}/.forward && chmod 644 /home/#{admin}/.forward"
      `#{cmd}`
    end
  end
  def gitify
    public_keys = find_member_public_keys
    add_keys_to_keydir(public_keys)
    GForge.new.commit_and_push_new_keys 
    add_group_block_to_gitosis_config_file(public_keys)
    GForge.new.commit_and_push_gitosis_conf 
  end
  def add_group_block_to_gitosis_config_file(keys)
   gc = GitosisConf.new("/home/tom/gitosis-admin/gitosis.conf")
   gc.add_or_update(unix_group_name, keys.collect { |k,v| k } )
   gc.write
  end
  def add_keys_to_keydir(public_keys)
    public_keys.each do |signature, keyblob|
      File.open(keydir_path_for(signature), "w") do |f|
        f.syswrite(keyblob)
      end
      FileUtils.chown("tom", "tom", keydir_path_for(signature))
    end
  end
  def keydir_path_for(signature)
    File.join(KEYDIR, signature + ".pub")
  end
  def show_steps_to_cvs2svn(clear=false)
    puts "Run these commands if they look right"
    puts "cd /tmp"
    puts "rm -rf /tmp/#{unix_group_name}" if File.exist?("/tmp/#{unix_group_name}")
    puts "rm -rf /tmp/#{unix_group_name}-repos" if File.exist?("/tmp/#{unix_group_name}-repos")
    puts "rm -rf #{svn_root}" if File.exist? svn_root
    if clear
      puts "svnadmin create --fs-type=fsfs #{unix_group_name}-repos"
    else 
      puts "cp -R #{cvs_root} ."
      puts "time cvs2svn -q --fs-type=fsfs -s #{unix_group_name}-repos #{unix_group_name}"
    end
    show_move_in_svn_repo_commands
    puts "psql -U gforge -c \"update groups set use_scm = 1 where unix_group_name = '#{unix_group_name}'\""
    puts "psql -U gforge -c \"update group_plugin set plugin_id = 4 where group_id in (select g.group_id from groups g where unix_group_name = '#{unix_group_name}') and plugin_id = 2\"\n"
    puts "tar -zcf /root/cvs2svnbackups/#{unix_group_name}.tar.gz #{cvs_root}"
    puts "rm -rf #{cvs_root}" 
    puts "rm -rf #{vhost_root}/statcvs/" 
    puts "rm -rf /tmp/#{unix_group_name}"
    puts "cd -"
    puts "Then edit #{vhost_conf} and add the svn part to their vhost:"
    puts File.read("httpd.entry.template").gsub(/projectname/, unix_group_name)
    puts "Then do a:"
    puts "#{APACHECTL} graceful"
  end
  def show_steps_to_svn2git(clear=false)
    puts "Run these commands if they look right"
    puts "psql -U gforge -c \"update groups set use_scm = 1 where unix_group_name = '#{unix_group_name}'\""
    puts "psql -U gforge -c \"update group_plugin set plugin_id = 5 where group_id in (select g.group_id from groups g where unix_group_name = '#{unix_group_name}') and plugin_id = 4\"\n"
    puts "sudo /home/tom/support/trunk/support/project.rb update_gitosis"
    if clear
      puts "du -skh #{svn_root}"
      puts "tar -zcf /root/cvs2svnbackups/#{unix_group_name}.tar.gz #{svn_root}"
      puts "rm -rf #{svn_root}"
    end
  end
  def find_member_public_keys
    gforge_public_key_separator = "###"
    valid_keys = {}
    users.each do |user|
      next if user.authorized_keys.nil?
      user.authorized_keys.split(gforge_public_key_separator).each do |key|
        parts = key.split(" ")
        signature = parts.last
        if signature =~ /^([a-zA-Z])+.*\@([a-zA-Z])+.*$/
          valid_keys[signature] = key
        end
      end
    end
    valid_keys
  end
  def cvs_root
    "/var/cvs/#{unix_group_name}/"
  end
  def wikify
    FileUtils.mkdir_p("#{wiki_dir}html")
    FileUtils.copy("/home/tom/support/trunk/support/usemod_wiki_template/wiki.pl", wiki_dir)
    FileUtils.copy("/home/tom/support/trunk/support/usemod_wiki_template/wiki.css", wiki_dir)
    FileUtils.chown("webuser", "webgroup", "#{wiki_dir}html")
    `chmod g+s #{wiki_dir}html`
  end
  def cvsify
    FileUtils.mkdir(cvs_root) 
    system "cvs -d#{cvs_root} init"
    FileUtils.touch "#{cvs_root}CVSROOT/history"
    system "cp /var/cvs/prototype/CVSROOT/loginfo* /var/cvs/prototype/CVSROOT/readers* /var/cvs/prototype/CVSROOT/passwd* /var/cvs/prototype/CVSROOT/config* /var/cvs/prototype/CVSROOT/cvswrappers* /var/cvs/prototype/CVSROOT/writers* #{cvs_root}/CVSROOT/"
    FileUtils.chmod_R(0755, cvs_root)
    system "chown -R #{first_admin.user_name}:#{unix_group_name} #{cvs_root}"
    system "chmod -R g+ws #{cvs_root}"
    FileUtils.chmod(0777, "#{cvs_root}/CVSROOT/history")
  end
  def svnify
    `rm -rf /var/svn/#{unix_group_name}` if File.exist?("/var/svn/#{unix_group_name}")
    `/usr/local/bin/svnadmin create --fs-type fsfs /var/svn/#{unix_group_name}`  
    `chown -R #{first_admin.user_name}:#{unix_group_name} /var/svn/#{unix_group_name} `  
    `chmod -R g+ws /var/svn/#{unix_group_name} `  
  end
  def provision_vhost
    File.open(vhost_conf, "w") do |f| 
      f.write(File.read("/home/tom/support/trunk/support/httpd.entry.template").gsub(/projectname/, unix_group_name))
    end
  end
  def provision_docroot
    FileUtils.mkdir_p(vhost_root)
    FileUtils.copy(ROBOTS_FILE, vhost_root)
    create_default_homepage
    `chown -R #{first_admin.user_name}:#{unix_group_name} #{vhost_root}`
    `chmod -R 775 #{vhost_root}`
    `chmod -R g+ws #{vhost_root}`
  end
  def create_default_homepage
    File.open("#{vhost_root}index.html", "w") {|f| f.syswrite(File.read("/home/tom/support/trunk/support/default_project_vhost_index.html").gsub(/\$project/, unix_group_name)) }
  end
  def vhost_root
    "/var/www/gforge-projects/#{unix_group_name}/"
  end
  def gforge_files_root
    "/var/www/gforge-files/#{unix_group_name}/"
  end
  def svn_root
    "/var/svn/#{unix_group_name}"
  end
  def scm_root
    if plugins.includes_svn?
      SVNROOT
    elsif plugins.includes_cvs?
      CVSROOT
    elsif plugins.includes_git?
      GITROOT
    end
  end
  def show_move_in_svn_repo_commands
    puts "mv #{unix_group_name}-repos #{svn_root}"
    puts "chown -R #{first_admin.user_name}:#{unix_group_name} #{svn_root}"  
    puts "chmod -R g+ws #{svn_root}"
  end
  def show_steps_to_resetsvn
    puts "Run these commands if they look right"
    puts "cd /tmp"
    puts "tar -zcf /root/cvs2svnbackups/#{unix_group_name}.tar.gz /var/svn/#{unix_group_name}"
    puts "rm -rf /var/svn/#{unix_group_name}" 
    puts "svnadmin create --fs-type=fsfs #{unix_group_name}-repos"
    show_steps_to_move_in_svn_repo
    puts "cd -"
  end
  def show_steps_to_delete
    puts "Mark project as deleted in web interface"
    puts "Delete mailing lists" if `egrep "#{unix_group_name}.*confirm" /etc/aliases`.strip.size > 0
    puts "Run the following commands if they look OK"
    puts "rm -f #{vhost_conf}"
    unless plugins.includes_git? # TODO should remove git repo and remove project from gitosis.conf
      puts "du -skh #{scm_root}#{unix_group_name}"
      puts "tar -zcf /root/project_bkps_just_in_case/#{unix_group_name}_#{plugins.scm.plugin_name}.tar.gz #{scm_root}#{unix_group_name}"
      puts "rm -rf #{scm_root}#{unix_group_name}"
    end
    puts "du -skh #{vhost_root}"
    puts "tar -zcf /root/project_bkps_just_in_case/#{unix_group_name}_www.tar.gz #{vhost_root}"
    puts "rm -rf #{vhost_root}"
    if File.exists? gforge_files_root
      puts "du -skh #{gforge_files_root}"
      puts "tar -zcf /root/project_bkps_just_in_case/#{unix_group_name}_files.tar.gz #{gforge_files_root}"
      puts "rm -rf #{gforge_files_root}"
    end
    puts "/usr/sbin/groupdel #{unix_group_name}"
    puts "#{APACHECTL} restart"
  end
end

