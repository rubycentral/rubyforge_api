# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090929161925) do

  create_table "activity_log", :id => false, :force => true do |t|
    t.integer "day",                   :default => 0,       :null => false
    t.integer "hour",                  :default => 0,       :null => false
    t.integer "group_id",              :default => 0,       :null => false
    t.string  "browser",  :limit => 8, :default => "OTHER", :null => false
    t.float   "ver",                                        :null => false
    t.string  "platform", :limit => 8, :default => "OTHER", :null => false
    t.integer "time",                  :default => 0,       :null => false
    t.text    "page"
    t.integer "type",                  :default => 0,       :null => false
  end

  create_table "activity_log_old", :id => false, :force => true do |t|
    t.integer "day",                   :default => 0,       :null => false
    t.integer "hour",                  :default => 0,       :null => false
    t.integer "group_id",              :default => 0,       :null => false
    t.string  "browser",  :limit => 8, :default => "OTHER", :null => false
    t.float   "ver",                                        :null => false
    t.string  "platform", :limit => 8, :default => "OTHER", :null => false
    t.integer "time",                  :default => 0,       :null => false
    t.text    "page"
    t.integer "type",                  :default => 0,       :null => false
  end

  create_table "activity_log_old_old", :id => false, :force => true do |t|
    t.integer "day",                   :default => 0,       :null => false
    t.integer "hour",                  :default => 0,       :null => false
    t.integer "group_id",              :default => 0,       :null => false
    t.string  "browser",  :limit => 8, :default => "OTHER", :null => false
    t.float   "ver",                                        :null => false
    t.string  "platform", :limit => 8, :default => "OTHER", :null => false
    t.integer "time",                  :default => 0,       :null => false
    t.text    "page"
    t.integer "type",                  :default => 0,       :null => false
  end

  create_table "api_requests", :force => true do |t|
    t.integer  "user_id"
    t.string   "ip_address"
    t.string   "path"
    t.string   "method"
    t.string   "response_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artifact", :primary_key => "artifact_id", :force => true do |t|
    t.integer "group_artifact_id",                  :null => false
    t.integer "status_id",         :default => 1,   :null => false
    t.integer "category_id",       :default => 100, :null => false
    t.integer "artifact_group_id", :default => 0,   :null => false
    t.integer "resolution_id",     :default => 100, :null => false
    t.integer "priority",          :default => 3,   :null => false
    t.integer "submitted_by",      :default => 100, :null => false
    t.integer "assigned_to",       :default => 100, :null => false
    t.integer "open_date",         :default => 0,   :null => false
    t.integer "close_date",        :default => 0,   :null => false
    t.text    "summary",                            :null => false
    t.text    "details",                            :null => false
  end

  add_index "artifact", ["assigned_to", "status_id"], :name => "art_assign_status"
  add_index "artifact", ["group_artifact_id", "artifact_id"], :name => "art_groupartid_artifactid"
  add_index "artifact", ["group_artifact_id", "assigned_to"], :name => "art_groupartid_assign"
  add_index "artifact", ["group_artifact_id", "status_id"], :name => "art_groupartid_statusid"
  add_index "artifact", ["group_artifact_id", "submitted_by"], :name => "art_groupartid_submit"
  add_index "artifact", ["group_artifact_id"], :name => "art_groupartid"
  add_index "artifact", ["submitted_by", "status_id"], :name => "art_submit_status"

  create_table "artifact_canned_responses", :force => true do |t|
    t.integer "group_artifact_id", :null => false
    t.text    "title",             :null => false
    t.text    "body",              :null => false
  end

  add_index "artifact_canned_responses", ["group_artifact_id"], :name => "artifactcannedresponses_groupid"

  create_table "artifact_category", :force => true do |t|
    t.integer "group_artifact_id",                  :null => false
    t.text    "category_name",                      :null => false
    t.integer "auto_assign_to",    :default => 100, :null => false
  end

  add_index "artifact_category", ["group_artifact_id"], :name => "artcategory_groupartifactid"

  create_table "artifact_counts_agg", :id => false, :force => true do |t|
    t.integer "group_artifact_id",                :null => false
    t.integer "count",             :default => 0, :null => false
    t.integer "open_count",        :default => 0
  end

  add_index "artifact_counts_agg", ["group_artifact_id"], :name => "artifactcountsagg_groupartid"

  create_table "artifact_extra_field_data", :primary_key => "data_id", :force => true do |t|
    t.integer "artifact_id",                   :null => false
    t.text    "field_data"
    t.integer "extra_field_id", :default => 0
  end

  create_table "artifact_extra_field_elements", :primary_key => "element_id", :force => true do |t|
    t.integer "extra_field_id", :null => false
    t.text    "element_name",   :null => false
  end

  create_table "artifact_extra_field_list", :primary_key => "extra_field_id", :force => true do |t|
    t.integer "group_artifact_id",                :null => false
    t.text    "field_name",                       :null => false
    t.integer "field_type",        :default => 1
    t.integer "attribute1",        :default => 0
    t.integer "attribute2",        :default => 0
  end

  create_table "artifact_file", :force => true do |t|
    t.integer "artifact_id",                 :null => false
    t.text    "description",                 :null => false
    t.text    "bin_data",                    :null => false
    t.text    "filename",                    :null => false
    t.integer "filesize",                    :null => false
    t.text    "filetype",                    :null => false
    t.integer "adddate",      :default => 0, :null => false
    t.integer "submitted_by",                :null => false
  end

  add_index "artifact_file", ["artifact_id", "adddate"], :name => "artfile_artid_adddate"
  add_index "artifact_file", ["artifact_id"], :name => "artfile_artid"

  create_table "artifact_group", :force => true do |t|
    t.integer "group_artifact_id", :null => false
    t.text    "group_name",        :null => false
  end

  add_index "artifact_group", ["group_artifact_id"], :name => "artgroup_groupartifactid"

  create_table "artifact_group_list", :primary_key => "group_artifact_id", :force => true do |t|
    t.integer "group_id",                                 :null => false
    t.text    "name"
    t.text    "description"
    t.integer "is_public",           :default => 0,       :null => false
    t.integer "allow_anon",          :default => 0,       :null => false
    t.integer "email_all_updates",   :default => 0,       :null => false
    t.text    "email_address",                            :null => false
    t.integer "due_period",          :default => 2592000, :null => false
    t.integer "use_resolution",      :default => 0,       :null => false
    t.text    "submit_instructions"
    t.text    "browse_instructions"
    t.integer "datatype",            :default => 0,       :null => false
    t.integer "status_timeout"
  end

  add_index "artifact_group_list", ["group_id", "is_public"], :name => "artgrouplist_groupid_public"
  add_index "artifact_group_list", ["group_id"], :name => "artgrouplist_groupid"

  create_table "artifact_history", :force => true do |t|
    t.integer "artifact_id", :default => 0,  :null => false
    t.text    "field_name",  :default => "", :null => false
    t.text    "old_value",   :default => "", :null => false
    t.integer "mod_by",      :default => 0,  :null => false
    t.integer "entrydate",   :default => 0,  :null => false
  end

  add_index "artifact_history", ["artifact_id", "entrydate"], :name => "arthistory_artid_entrydate"
  add_index "artifact_history", ["artifact_id"], :name => "arthistory_artid"

  create_table "artifact_message", :force => true do |t|
    t.integer "artifact_id",                 :null => false
    t.integer "submitted_by",                :null => false
    t.text    "from_email",                  :null => false
    t.integer "adddate",      :default => 0, :null => false
    t.text    "body",                        :null => false
  end

  add_index "artifact_message", ["artifact_id", "adddate"], :name => "artmessage_artid_adddate"
  add_index "artifact_message", ["artifact_id"], :name => "artmessage_artid"

  create_table "artifact_monitor", :force => true do |t|
    t.integer "artifact_id", :null => false
    t.integer "user_id",     :null => false
    t.text    "email"
  end

  add_index "artifact_monitor", ["artifact_id"], :name => "artmonitor_artifactid"

  create_table "artifact_perm", :force => true do |t|
    t.integer "group_artifact_id",                :null => false
    t.integer "user_id",                          :null => false
    t.integer "perm_level",        :default => 0, :null => false
  end

  add_index "artifact_perm", ["group_artifact_id", "user_id"], :name => "artperm_groupartifactid_userid", :unique => true
  add_index "artifact_perm", ["group_artifact_id"], :name => "artperm_groupartifactid"

  create_table "artifact_resolution", :force => true do |t|
    t.text "resolution_name"
  end

  create_table "artifact_status", :force => true do |t|
    t.text "status_name", :null => false
  end

  create_table "canned_responses", :primary_key => "response_id", :force => true do |t|
    t.string "response_title", :limit => 25
    t.text   "response_text"
  end

  create_table "country_code", :id => false, :force => true do |t|
    t.string "country_name", :limit => 80
    t.string "ccode",        :limit => 2,  :null => false
  end

  create_table "cron_history", :id => false, :force => true do |t|
    t.integer "rundate", :null => false
    t.text    "job"
    t.text    "output"
  end

  add_index "cron_history", ["rundate"], :name => "cronhist_rundate"

  create_table "db_images", :force => true do |t|
    t.integer "group_id",    :default => 0,  :null => false
    t.text    "description", :default => "", :null => false
    t.text    "bin_data",    :default => "", :null => false
    t.text    "filename",    :default => "", :null => false
    t.integer "filesize",    :default => 0,  :null => false
    t.text    "filetype",    :default => "", :null => false
    t.integer "width",       :default => 0,  :null => false
    t.integer "height",      :default => 0,  :null => false
    t.integer "upload_date"
    t.integer "version"
  end

  add_index "db_images", ["group_id"], :name => "db_images_group"

  create_table "disk_usages", :force => true do |t|
    t.integer  "group_id",                                 :null => false
    t.integer  "scm_space_used",            :default => 0
    t.integer  "released_files_space_used", :default => 0
    t.integer  "virtual_host_space_used",   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_data", :primary_key => "docid", :force => true do |t|
    t.integer "stateid",     :default => 0,  :null => false
    t.string  "title",       :default => "", :null => false
    t.text    "data",        :default => "", :null => false
    t.integer "updatedate",  :default => 0,  :null => false
    t.integer "createdate",  :default => 0,  :null => false
    t.integer "created_by",  :default => 0,  :null => false
    t.integer "doc_group",   :default => 0,  :null => false
    t.text    "description"
    t.integer "language_id", :default => 1,  :null => false
    t.text    "filename"
    t.text    "filetype"
    t.integer "group_id"
  end

  add_index "doc_data", ["doc_group"], :name => "doc_group_doc_group"

  create_table "doc_groups", :primary_key => "doc_group", :force => true do |t|
    t.string  "groupname", :default => "", :null => false
    t.integer "group_id",  :default => 0,  :null => false
  end

  add_index "doc_groups", ["group_id"], :name => "doc_groups_group"

  create_table "doc_states", :primary_key => "stateid", :force => true do |t|
    t.string "name", :default => "", :null => false
  end

  create_table "filemodule_monitor", :force => true do |t|
    t.integer "filemodule_id", :default => 0, :null => false
    t.integer "user_id",       :default => 0, :null => false
  end

  add_index "filemodule_monitor", ["filemodule_id"], :name => "filemodule_monitor_id"
  add_index "filemodule_monitor", ["user_id"], :name => "filemodulemonitor_userid"

  create_table "forum", :primary_key => "msg_id", :force => true do |t|
    t.integer "group_forum_id",   :default => 0,  :null => false
    t.integer "posted_by",        :default => 0,  :null => false
    t.text    "subject",          :default => "", :null => false
    t.text    "body",             :default => "", :null => false
    t.integer "post_date",        :default => 0,  :null => false
    t.integer "is_followup_to",   :default => 0,  :null => false
    t.integer "thread_id",        :default => 0,  :null => false
    t.integer "has_followups",    :default => 0
    t.integer "most_recent_date", :default => 0,  :null => false
  end

  add_index "forum", ["group_forum_id", "is_followup_to", "most_recent_date"], :name => "forum_forumid_isfollto_mostrece"
  add_index "forum", ["group_forum_id", "msg_id"], :name => "forum_forumid_msgid"
  add_index "forum", ["group_forum_id", "thread_id", "most_recent_date"], :name => "forum_forumid_threadid_mostrece"
  add_index "forum", ["group_forum_id"], :name => "forum_group_forum_id"
  add_index "forum", ["thread_id", "is_followup_to"], :name => "forum_threadid_isfollowupto"

  create_table "forum_agg_msg_count", :id => false, :force => true do |t|
    t.integer "group_forum_id", :default => 0, :null => false
    t.integer "count",          :default => 0, :null => false
  end

  create_table "forum_group_list", :primary_key => "group_forum_id", :force => true do |t|
    t.integer "group_id",          :default => 0,  :null => false
    t.text    "forum_name",        :default => "", :null => false
    t.integer "is_public",         :default => 0,  :null => false
    t.text    "description"
    t.integer "allow_anonymous",   :default => 0,  :null => false
    t.text    "send_all_posts_to"
  end

  add_index "forum_group_list", ["group_id"], :name => "forum_group_list_group_id"

  create_table "forum_monitored_forums", :primary_key => "monitor_id", :force => true do |t|
    t.integer "forum_id", :default => 0, :null => false
    t.integer "user_id",  :default => 0, :null => false
  end

  add_index "forum_monitored_forums", ["forum_id", "user_id"], :name => "forum_monitor_combo_id"
  add_index "forum_monitored_forums", ["forum_id"], :name => "forum_monitor_thread_id"
  add_index "forum_monitored_forums", ["user_id"], :name => "forummonitoredforums_user"

  create_table "forum_perm", :id => false, :force => true do |t|
    t.integer "id",                            :null => false
    t.integer "group_forum_id",                :null => false
    t.integer "user_id",                       :null => false
    t.integer "perm_level",     :default => 0, :null => false
  end

  add_index "forum_perm", ["group_forum_id", "user_id"], :name => "forumperm_groupforumiduserid", :unique => true
  add_index "forum_perm", ["id"], :name => "forum_perm_id_key", :unique => true

  create_table "forum_saved_place", :primary_key => "saved_place_id", :force => true do |t|
    t.integer "user_id",   :default => 0, :null => false
    t.integer "forum_id",  :default => 0, :null => false
    t.integer "save_date", :default => 0, :null => false
  end

  create_table "frs_dlstats_file", :id => false, :force => true do |t|
    t.text    "ip_address"
    t.integer "file_id"
    t.integer "month"
    t.integer "day"
    t.integer "user_id"
  end

  create_table "frs_dlstats_filetotal_agg", :id => false, :force => true do |t|
    t.integer "file_id"
    t.integer "downloads"
  end

  add_index "frs_dlstats_filetotal_agg", ["file_id"], :name => "frsdlfiletotal_fileid"

  create_table "frs_file", :primary_key => "file_id", :force => true do |t|
    t.text    "filename"
    t.integer "release_id",   :default => 0, :null => false
    t.integer "type_id",      :default => 0, :null => false
    t.integer "processor_id", :default => 0, :null => false
    t.integer "release_time", :default => 0, :null => false
    t.integer "file_size",    :default => 0, :null => false
    t.integer "post_date",    :default => 0, :null => false
  end

  add_index "frs_file", ["post_date"], :name => "frs_file_date"
  add_index "frs_file", ["release_id"], :name => "frs_file_release_id"

  create_table "frs_filetype", :primary_key => "type_id", :force => true do |t|
    t.text "name"
  end

  create_table "frs_package", :primary_key => "package_id", :force => true do |t|
    t.integer "group_id",  :default => 0, :null => false
    t.text    "name"
    t.integer "status_id", :default => 0, :null => false
    t.integer "is_public", :default => 1
  end

  add_index "frs_package", ["group_id"], :name => "package_group_id"

  create_table "frs_processor", :primary_key => "processor_id", :force => true do |t|
    t.text "name"
  end

  create_table "frs_release", :primary_key => "release_id", :force => true do |t|
    t.integer "package_id",   :default => 0, :null => false
    t.text    "name"
    t.text    "notes"
    t.text    "changes"
    t.integer "status_id",    :default => 0, :null => false
    t.integer "preformatted", :default => 0, :null => false
    t.integer "release_date", :default => 0, :null => false
    t.integer "released_by",  :default => 0, :null => false
  end

  add_index "frs_release", ["package_id"], :name => "frs_release_package"

  create_table "frs_status", :primary_key => "status_id", :force => true do |t|
    t.text "name"
  end

  create_table "gem_downloads", :id => false, :force => true do |t|
    t.string   "ip",               :limit => 16, :null => false
    t.datetime "downloaded_at",                  :null => false
    t.string   "gem_name",         :limit => 64, :null => false
    t.string   "client_signature", :limit => 32, :null => false
  end

  create_table "gem_namespace_ownerships", :force => true do |t|
    t.integer  "group_id",   :null => false
    t.string   "namespace",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "group_cvs_history", :id => false, :force => true do |t|
    t.integer "id",                                           :null => false
    t.integer "group_id",                     :default => 0,  :null => false
    t.string  "user_name",      :limit => 80, :default => "", :null => false
    t.integer "cvs_commits",                  :default => 0,  :null => false
    t.integer "cvs_commits_wk",               :default => 0,  :null => false
    t.integer "cvs_adds",                     :default => 0,  :null => false
    t.integer "cvs_adds_wk",                  :default => 0,  :null => false
  end

  add_index "group_cvs_history", ["group_id"], :name => "groupcvshistory_groupid"
  add_index "group_cvs_history", ["id"], :name => "group_cvs_history_id_key", :unique => true

  create_table "group_history", :primary_key => "group_history_id", :force => true do |t|
    t.integer "group_id",   :default => 0,  :null => false
    t.text    "field_name", :default => "", :null => false
    t.text    "old_value",  :default => "", :null => false
    t.integer "mod_by",     :default => 0,  :null => false
    t.integer "adddate"
  end

  add_index "group_history", ["group_id"], :name => "group_history_group_id"

  create_table "group_plugin", :primary_key => "group_plugin_id", :force => true do |t|
    t.integer "group_id"
    t.integer "plugin_id"
  end

  create_table "groups", :primary_key => "group_id", :force => true do |t|
    t.string  "group_name",                    :limit => 40
    t.string  "homepage",                      :limit => 128
    t.integer "is_public",                                    :default => 0,        :null => false
    t.string  "status",                        :limit => 1,   :default => "A",      :null => false
    t.string  "unix_group_name",               :limit => 30,  :default => "",       :null => false
    t.string  "unix_box",                      :limit => 20,  :default => "shell1", :null => false
    t.string  "http_domain",                   :limit => 80
    t.string  "short_description"
    t.text    "register_purpose"
    t.text    "license_other"
    t.integer "register_time",                                :default => 0,        :null => false
    t.text    "rand_hash"
    t.integer "use_mail",                                     :default => 1,        :null => false
    t.integer "use_survey",                                   :default => 1,        :null => false
    t.integer "use_forum",                                    :default => 1,        :null => false
    t.integer "use_pm",                                       :default => 1,        :null => false
    t.integer "use_scm",                                      :default => 1,        :null => false
    t.integer "use_news",                                     :default => 1,        :null => false
    t.integer "type_id",                                      :default => 1,        :null => false
    t.integer "use_docman",                                   :default => 1,        :null => false
    t.text    "new_doc_address",                              :default => "",       :null => false
    t.integer "send_all_docs",                                :default => 0,        :null => false
    t.integer "use_pm_depend_box",                            :default => 1,        :null => false
    t.integer "use_ftp",                                      :default => 0
    t.integer "use_tracker",                                  :default => 1
    t.integer "use_frs",                                      :default => 1
    t.integer "use_stats",                                    :default => 1
    t.integer "enable_pserver",                               :default => 1
    t.integer "enable_anonscm",                               :default => 1
    t.string  "sys_state",                     :limit => 1,   :default => "N"
    t.integer "license",                                      :default => 100
    t.text    "scm_box"
    t.boolean "needs_vhost_permissions_reset",                :default => false
  end

  add_index "groups", ["is_public"], :name => "groups_public"
  add_index "groups", ["status"], :name => "groups_status"
  add_index "groups", ["type_id"], :name => "groups_type"
  add_index "groups", ["unix_group_name"], :name => "group_unix_uniq", :unique => true

  create_table "licenses", :id => false, :force => true do |t|
    t.integer "license_id",   :null => false
    t.text    "license_name"
  end

  add_index "licenses", ["license_id"], :name => "licenses_license_id_key", :unique => true

  create_table "mail_group_list", :primary_key => "group_list_id", :force => true do |t|
    t.integer "group_id",                  :default => 0, :null => false
    t.text    "list_name"
    t.integer "is_public",                 :default => 0, :null => false
    t.string  "password",    :limit => 16
    t.integer "list_admin",                :default => 0, :null => false
    t.integer "status",                    :default => 0, :null => false
    t.text    "description"
  end

  add_index "mail_group_list", ["group_id"], :name => "mail_group_list_group"

  create_table "massmail_queue", :force => true do |t|
    t.string  "type",          :limit => 8,                :null => false
    t.text    "subject",                                   :null => false
    t.text    "message",                                   :null => false
    t.integer "queued_date",                               :null => false
    t.integer "last_userid",                :default => 0, :null => false
    t.integer "failed_date",                :default => 0, :null => false
    t.integer "finished_date",              :default => 0, :null => false
  end

  create_table "mirrors", :force => true do |t|
    t.string   "domain",                                 :null => false
    t.boolean  "enabled",             :default => true,  :null => false
    t.boolean  "serves_gems",         :default => false, :null => false
    t.boolean  "serves_files",        :default => false, :null => false
    t.string   "administrator_name",  :default => ""
    t.string   "administrator_email", :default => ""
    t.string   "url",                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "load_factor",         :default => 1,     :null => false
  end

  create_table "news_bytes", :force => true do |t|
    t.integer "group_id",     :default => 0, :null => false
    t.integer "submitted_by", :default => 0, :null => false
    t.integer "is_approved",  :default => 0, :null => false
    t.integer "post_date",    :default => 0, :null => false
    t.integer "forum_id",     :default => 0, :null => false
    t.text    "summary"
    t.text    "details"
  end

  add_index "news_bytes", ["forum_id"], :name => "news_bytes_forum"
  add_index "news_bytes", ["group_id", "post_date"], :name => "news_group_date"
  add_index "news_bytes", ["group_id"], :name => "news_bytes_group"
  add_index "news_bytes", ["is_approved", "post_date"], :name => "news_approved_date"
  add_index "news_bytes", ["is_approved"], :name => "news_bytes_approved"

  create_table "people_job", :primary_key => "job_id", :force => true do |t|
    t.integer "group_id",    :default => 0, :null => false
    t.integer "created_by",  :default => 0, :null => false
    t.text    "title"
    t.text    "description"
    t.integer "post_date",   :default => 0, :null => false
    t.integer "status_id",   :default => 0, :null => false
    t.integer "category_id", :default => 0, :null => false
  end

  add_index "people_job", ["group_id"], :name => "people_job_group_id"

  create_table "people_job_category", :primary_key => "category_id", :force => true do |t|
    t.text    "name"
    t.integer "private_flag", :default => 0, :null => false
  end

  create_table "people_job_inventory", :primary_key => "job_inventory_id", :force => true do |t|
    t.integer "job_id",         :default => 0, :null => false
    t.integer "skill_id",       :default => 0, :null => false
    t.integer "skill_level_id", :default => 0, :null => false
    t.integer "skill_year_id",  :default => 0, :null => false
  end

  create_table "people_job_status", :primary_key => "status_id", :force => true do |t|
    t.text "name"
  end

  create_table "people_skill", :primary_key => "skill_id", :force => true do |t|
    t.text "name"
  end

  create_table "people_skill_inventory", :primary_key => "skill_inventory_id", :force => true do |t|
    t.integer "user_id",        :default => 0, :null => false
    t.integer "skill_id",       :default => 0, :null => false
    t.integer "skill_level_id", :default => 0, :null => false
    t.integer "skill_year_id",  :default => 0, :null => false
  end

  create_table "people_skill_level", :primary_key => "skill_level_id", :force => true do |t|
    t.text "name"
  end

  create_table "people_skill_year", :primary_key => "skill_year_id", :force => true do |t|
    t.text "name"
  end

  create_table "plugins", :primary_key => "plugin_id", :force => true do |t|
    t.string "plugin_name", :limit => 32, :null => false
    t.text   "plugin_desc"
  end

  add_index "plugins", ["plugin_name"], :name => "plugins_plugin_name_key", :unique => true

  create_table "prdb_dbs", :primary_key => "dbid", :force => true do |t|
    t.integer "group_id",    :null => false
    t.text    "dbname",      :null => false
    t.text    "dbusername",  :null => false
    t.text    "dbuserpass",  :null => false
    t.integer "requestdate", :null => false
    t.integer "dbtype",      :null => false
    t.integer "created_by",  :null => false
    t.integer "state",       :null => false
  end

  add_index "prdb_dbs", ["dbname"], :name => "idx_prdb_dbname", :unique => true

  create_table "prdb_states", :id => false, :force => true do |t|
    t.integer "stateid",   :null => false
    t.text    "statename"
  end

  create_table "prdb_types", :id => false, :force => true do |t|
    t.integer "dbtypeid",     :null => false
    t.text    "dbservername", :null => false
    t.text    "dbsoftware",   :null => false
  end

  create_table "project_assigned_to", :primary_key => "project_assigned_id", :force => true do |t|
    t.integer "project_task_id", :default => 0, :null => false
    t.integer "assigned_to_id",  :default => 0, :null => false
  end

  add_index "project_assigned_to", ["assigned_to_id"], :name => "project_assigned_to_assigned_to"
  add_index "project_assigned_to", ["project_task_id"], :name => "project_assigned_to_task_id"

  create_table "project_category", :id => false, :force => true do |t|
    t.integer "category_id",      :null => false
    t.integer "group_project_id"
    t.text    "category_name"
  end

  add_index "project_category", ["category_id"], :name => "project_categor_category_id_key", :unique => true
  add_index "project_category", ["group_project_id"], :name => "projectcategory_groupprojectid"

  create_table "project_counts_agg", :id => false, :force => true do |t|
    t.integer "group_project_id",                :null => false
    t.integer "count",            :default => 0, :null => false
    t.integer "open_count",       :default => 0
  end

  create_table "project_dependencies", :primary_key => "project_depend_id", :force => true do |t|
    t.integer "project_task_id",                      :default => 0,    :null => false
    t.integer "is_dependent_on_task_id",              :default => 0,    :null => false
    t.string  "link_type",               :limit => 2, :default => "SS"
  end

  add_index "project_dependencies", ["is_dependent_on_task_id"], :name => "project_is_dependent_on_task_id"
  add_index "project_dependencies", ["project_task_id"], :name => "project_dependencies_task_id"

  create_table "project_group_doccat", :id => false, :force => true do |t|
    t.integer "group_project_id"
    t.integer "doc_group_id"
  end

  add_index "project_group_doccat", ["doc_group_id"], :name => "projectgroupdoccat_groupgroupid"

  create_table "project_group_forum", :id => false, :force => true do |t|
    t.integer "group_project_id"
    t.integer "group_forum_id"
  end

  add_index "project_group_forum", ["group_forum_id"], :name => "projectgroupforum_groupforumid"
  add_index "project_group_forum", ["group_project_id"], :name => "projectgroupdoccat_groupproject"
  add_index "project_group_forum", ["group_project_id"], :name => "projectgroupforum_groupprojecti"

  create_table "project_group_list", :primary_key => "group_project_id", :force => true do |t|
    t.integer "group_id",          :default => 0,  :null => false
    t.text    "project_name",      :default => "", :null => false
    t.integer "is_public",         :default => 0,  :null => false
    t.text    "description"
    t.text    "send_all_posts_to"
  end

  add_index "project_group_list", ["group_id"], :name => "project_group_list_group_id"

  create_table "project_history", :primary_key => "project_history_id", :force => true do |t|
    t.integer "project_task_id", :default => 0,  :null => false
    t.text    "field_name",      :default => "", :null => false
    t.text    "old_value",       :default => "", :null => false
    t.integer "mod_by",          :default => 0,  :null => false
    t.integer "mod_date",        :default => 0,  :null => false
  end

  add_index "project_history", ["project_task_id"], :name => "project_history_task_id"

  create_table "project_messages", :id => false, :force => true do |t|
    t.integer "project_message_id", :null => false
    t.integer "project_task_id",    :null => false
    t.text    "body"
    t.integer "posted_by",          :null => false
    t.integer "postdate",           :null => false
  end

  add_index "project_messages", ["project_message_id"], :name => "project_messa_project_messa_key", :unique => true

  create_table "project_metric", :primary_key => "ranking", :force => true do |t|
    t.float   "percentile"
    t.integer "group_id",   :default => 0, :null => false
  end

  add_index "project_metric", ["group_id"], :name => "project_metric_group"

  create_table "project_metric_tmp1", :primary_key => "ranking", :force => true do |t|
    t.integer "group_id", :default => 0, :null => false
    t.float   "value"
  end

  create_table "project_perm", :id => false, :force => true do |t|
    t.integer "id",                              :null => false
    t.integer "group_project_id",                :null => false
    t.integer "user_id",                         :null => false
    t.integer "perm_level",       :default => 0, :null => false
  end

  add_index "project_perm", ["group_project_id", "user_id"], :name => "projectperm_groupprojiduserid", :unique => true
  add_index "project_perm", ["id"], :name => "project_perm_id_key", :unique => true

  create_table "project_status", :primary_key => "status_id", :force => true do |t|
    t.text "status_name", :default => "", :null => false
  end

  create_table "project_sums_agg", :id => false, :force => true do |t|
    t.integer "group_id",              :default => 0, :null => false
    t.string  "type",     :limit => 4
    t.integer "count",                 :default => 0, :null => false
  end

  add_index "project_sums_agg", ["group_id"], :name => "projectsumsagg_groupid"

  create_table "project_task", :primary_key => "project_task_id", :force => true do |t|
    t.integer "group_project_id", :default => 0,  :null => false
    t.text    "summary",          :default => "", :null => false
    t.text    "details",          :default => "", :null => false
    t.integer "percent_complete", :default => 0,  :null => false
    t.integer "priority",         :default => 3,  :null => false
    t.float   "hours",                            :null => false
    t.integer "start_date",       :default => 0,  :null => false
    t.integer "end_date",         :default => 0,  :null => false
    t.integer "created_by",       :default => 0,  :null => false
    t.integer "status_id",        :default => 0,  :null => false
    t.integer "category_id"
    t.integer "duration",         :default => 0
    t.integer "parent_id",        :default => 0
  end

  add_index "project_task", ["group_project_id", "status_id"], :name => "projecttask_projid_status"
  add_index "project_task", ["group_project_id"], :name => "project_task_group_project_id"

  create_table "project_task_artifact", :id => false, :force => true do |t|
    t.integer "project_task_id"
    t.integer "artifact_id"
  end

  add_index "project_task_artifact", ["artifact_id"], :name => "projecttaskartifact_artifactid"
  add_index "project_task_artifact", ["project_task_id"], :name => "projecttaskartifact_projecttask"

  create_table "project_task_external_order", :id => false, :force => true do |t|
    t.integer "project_task_id", :null => false
    t.integer "external_id",     :null => false
  end

  add_index "project_task_external_order", ["project_task_id", "external_id"], :name => "projecttaskexternal_projtaskid"

  create_table "project_weekly_metric", :id => false, :force => true do |t|
    t.integer "ranking",                   :null => false
    t.float   "percentile"
    t.integer "group_id",   :default => 0, :null => false
  end

  add_index "project_weekly_metric", ["group_id"], :name => "project_metric_weekly_group"
  add_index "project_weekly_metric", ["ranking"], :name => "projectweeklymetric_ranking"

  create_table "prweb_vhost", :primary_key => "vhostid", :force => true do |t|
    t.text    "vhost_name"
    t.text    "docdir"
    t.text    "cgidir"
    t.integer "group_id",   :null => false
  end

  add_index "prweb_vhost", ["group_id"], :name => "idx_vhost_groups"
  add_index "prweb_vhost", ["vhost_name"], :name => "idx_vhost_hostnames", :unique => true

  create_table "rep_group_act_daily", :id => false, :force => true do |t|
    t.integer "group_id",       :null => false
    t.integer "day",            :null => false
    t.integer "tracker_opened", :null => false
    t.integer "tracker_closed", :null => false
    t.integer "forum",          :null => false
    t.integer "docs",           :null => false
    t.integer "downloads",      :null => false
    t.integer "cvs_commits",    :null => false
    t.integer "tasks_opened",   :null => false
    t.integer "tasks_closed",   :null => false
  end

  add_index "rep_group_act_daily", ["day"], :name => "repgroupactdaily_day"

  create_table "rep_group_act_monthly", :id => false, :force => true do |t|
    t.integer "group_id",       :null => false
    t.integer "month",          :null => false
    t.integer "tracker_opened", :null => false
    t.integer "tracker_closed", :null => false
    t.integer "forum",          :null => false
    t.integer "docs",           :null => false
    t.integer "downloads",      :null => false
    t.integer "cvs_commits",    :null => false
    t.integer "tasks_opened",   :null => false
    t.integer "tasks_closed",   :null => false
  end

  add_index "rep_group_act_monthly", ["month"], :name => "repgroupactmonthly_month"

  create_table "rep_group_act_weekly", :id => false, :force => true do |t|
    t.integer "group_id",       :null => false
    t.integer "week",           :null => false
    t.integer "tracker_opened", :null => false
    t.integer "tracker_closed", :null => false
    t.integer "forum",          :null => false
    t.integer "docs",           :null => false
    t.integer "downloads",      :null => false
    t.integer "cvs_commits",    :null => false
    t.integer "tasks_opened",   :null => false
    t.integer "tasks_closed",   :null => false
  end

  add_index "rep_group_act_weekly", ["week"], :name => "repgroupactweekly_week"

  create_table "rep_groups_added_daily", :id => false, :force => true do |t|
    t.integer "day",                  :null => false
    t.integer "added", :default => 0, :null => false
  end

  create_table "rep_groups_added_monthly", :id => false, :force => true do |t|
    t.integer "month",                :null => false
    t.integer "added", :default => 0, :null => false
  end

  create_table "rep_groups_added_weekly", :id => false, :force => true do |t|
    t.integer "week",                 :null => false
    t.integer "added", :default => 0, :null => false
  end

  create_table "rep_groups_cum_daily", :id => false, :force => true do |t|
    t.integer "day",                  :null => false
    t.integer "total", :default => 0, :null => false
  end

  create_table "rep_groups_cum_monthly", :id => false, :force => true do |t|
    t.integer "month",                :null => false
    t.integer "total", :default => 0, :null => false
  end

  create_table "rep_groups_cum_weekly", :id => false, :force => true do |t|
    t.integer "week",                 :null => false
    t.integer "total", :default => 0, :null => false
  end

  create_table "rep_time_category", :id => false, :force => true do |t|
    t.integer "time_code",     :null => false
    t.text    "category_name"
  end

  add_index "rep_time_category", ["time_code"], :name => "rep_time_category_time_code_key", :unique => true

  create_table "rep_time_tracking", :id => false, :force => true do |t|
    t.integer "week",            :null => false
    t.integer "report_date",     :null => false
    t.integer "user_id",         :null => false
    t.integer "project_task_id", :null => false
    t.integer "time_code",       :null => false
    t.float   "hours",           :null => false
  end

  add_index "rep_time_tracking", ["user_id", "week"], :name => "reptimetracking_userdate"

  create_table "rep_user_act_daily", :id => false, :force => true do |t|
    t.integer "user_id",        :null => false
    t.integer "day",            :null => false
    t.integer "tracker_opened", :null => false
    t.integer "tracker_closed", :null => false
    t.integer "forum",          :null => false
    t.integer "docs",           :null => false
    t.integer "cvs_commits",    :null => false
    t.integer "tasks_opened",   :null => false
    t.integer "tasks_closed",   :null => false
  end

  create_table "rep_user_act_monthly", :id => false, :force => true do |t|
    t.integer "user_id",        :null => false
    t.integer "month",          :null => false
    t.integer "tracker_opened", :null => false
    t.integer "tracker_closed", :null => false
    t.integer "forum",          :null => false
    t.integer "docs",           :null => false
    t.integer "cvs_commits",    :null => false
    t.integer "tasks_opened",   :null => false
    t.integer "tasks_closed",   :null => false
  end

  create_table "rep_user_act_weekly", :id => false, :force => true do |t|
    t.integer "user_id",        :null => false
    t.integer "week",           :null => false
    t.integer "tracker_opened", :null => false
    t.integer "tracker_closed", :null => false
    t.integer "forum",          :null => false
    t.integer "docs",           :null => false
    t.integer "cvs_commits",    :null => false
    t.integer "tasks_opened",   :null => false
    t.integer "tasks_closed",   :null => false
  end

  create_table "rep_users_added_daily", :id => false, :force => true do |t|
    t.integer "day",                  :null => false
    t.integer "added", :default => 0, :null => false
  end

  create_table "rep_users_added_monthly", :id => false, :force => true do |t|
    t.integer "month",                :null => false
    t.integer "added", :default => 0, :null => false
  end

  create_table "rep_users_added_weekly", :id => false, :force => true do |t|
    t.integer "week",                 :null => false
    t.integer "added", :default => 0, :null => false
  end

  create_table "rep_users_cum_daily", :id => false, :force => true do |t|
    t.integer "day",                  :null => false
    t.integer "total", :default => 0, :null => false
  end

  create_table "rep_users_cum_monthly", :id => false, :force => true do |t|
    t.integer "month",                :null => false
    t.integer "total", :default => 0, :null => false
  end

  create_table "rep_users_cum_weekly", :id => false, :force => true do |t|
    t.integer "week",                 :null => false
    t.integer "total", :default => 0, :null => false
  end

  create_table "role", :id => false, :force => true do |t|
    t.integer "role_id",   :null => false
    t.integer "group_id",  :null => false
    t.text    "role_name"
  end

  add_index "role", ["group_id", "role_id"], :name => "role_groupidroleid", :unique => true
  add_index "role", ["role_id"], :name => "role_role_id_key", :unique => true

  create_table "role_setting", :id => false, :force => true do |t|
    t.integer "role_id",                   :null => false
    t.text    "section_name",              :null => false
    t.integer "ref_id",                    :null => false
    t.string  "value",        :limit => 2, :null => false
  end

  add_index "role_setting", ["role_id", "section_name"], :name => "rolesetting_roleidsectionid"

  create_table "skills_data", :primary_key => "skills_data_id", :force => true do |t|
    t.integer "user_id",                 :default => 0,  :null => false
    t.integer "type",                    :default => 0,  :null => false
    t.string  "title",    :limit => 100, :default => "", :null => false
    t.integer "start",                   :default => 0,  :null => false
    t.integer "finish",                  :default => 0,  :null => false
    t.string  "keywords",                :default => "", :null => false
  end

  create_table "skills_data_types", :primary_key => "type_id", :force => true do |t|
    t.string "type_name", :limit => 25, :default => "", :null => false
  end

  create_table "snippet", :primary_key => "snippet_id", :force => true do |t|
    t.integer "created_by",  :default => 0,  :null => false
    t.text    "name"
    t.text    "description"
    t.integer "type",        :default => 0,  :null => false
    t.integer "language",    :default => 0,  :null => false
    t.text    "license",     :default => "", :null => false
    t.integer "category",    :default => 0,  :null => false
  end

  add_index "snippet", ["category"], :name => "snippet_category"
  add_index "snippet", ["language"], :name => "snippet_language"

  create_table "snippet_package", :primary_key => "snippet_package_id", :force => true do |t|
    t.integer "created_by",  :default => 0, :null => false
    t.text    "name"
    t.text    "description"
    t.integer "category",    :default => 0, :null => false
    t.integer "language",    :default => 0, :null => false
  end

  add_index "snippet_package", ["category"], :name => "snippet_package_category"
  add_index "snippet_package", ["language"], :name => "snippet_package_language"

  create_table "snippet_package_item", :primary_key => "snippet_package_item_id", :force => true do |t|
    t.integer "snippet_package_version_id", :default => 0, :null => false
    t.integer "snippet_version_id",         :default => 0, :null => false
  end

  add_index "snippet_package_item", ["snippet_package_version_id"], :name => "snippet_package_item_pkg_ver"

  create_table "snippet_package_version", :primary_key => "snippet_package_version_id", :force => true do |t|
    t.integer "snippet_package_id", :default => 0, :null => false
    t.text    "changes"
    t.text    "version"
    t.integer "submitted_by",       :default => 0, :null => false
    t.integer "post_date",          :default => 0, :null => false
  end

  add_index "snippet_package_version", ["snippet_package_id"], :name => "snippet_package_version_pkg_id"

  create_table "snippet_version", :primary_key => "snippet_version_id", :force => true do |t|
    t.integer "snippet_id",   :default => 0, :null => false
    t.text    "changes"
    t.text    "version"
    t.integer "submitted_by", :default => 0, :null => false
    t.integer "post_date",    :default => 0, :null => false
    t.text    "code"
  end

  add_index "snippet_version", ["snippet_id"], :name => "snippet_version_snippet_id"

  create_table "stats_agg_logo_by_day", :id => false, :force => true do |t|
    t.integer "day"
    t.integer "count"
  end

  create_table "stats_agg_logo_by_group", :id => false, :force => true do |t|
    t.integer "month"
    t.integer "day"
    t.integer "group_id"
    t.integer "count"
  end

  add_index "stats_agg_logo_by_group", ["month", "day", "group_id"], :name => "statslogobygroup_month_day_grou", :unique => true
  add_index "stats_agg_logo_by_group", ["oid"], :name => "statsagglogobygrp_oid", :unique => true

  create_table "stats_agg_pages_by_day", :id => false, :force => true do |t|
    t.integer "day",   :default => 0, :null => false
    t.integer "count", :default => 0, :null => false
  end

  add_index "stats_agg_pages_by_day", ["day"], :name => "pages_by_day_day"

  create_table "stats_agg_site_by_group", :id => false, :force => true do |t|
    t.integer "month"
    t.integer "day"
    t.integer "group_id"
    t.integer "count"
  end

  add_index "stats_agg_site_by_group", ["month", "day", "group_id"], :name => "statssitebygroup_month_day_grou", :unique => true
  add_index "stats_agg_site_by_group", ["oid"], :name => "statsaggsitebygrp_oid", :unique => true

  create_table "stats_cvs_group", :id => false, :force => true do |t|
    t.integer "month",     :default => 0, :null => false
    t.integer "day",       :default => 0, :null => false
    t.integer "group_id",  :default => 0, :null => false
    t.integer "checkouts", :default => 0, :null => false
    t.integer "commits",   :default => 0, :null => false
    t.integer "adds",      :default => 0, :null => false
  end

  add_index "stats_cvs_group", ["month", "day", "group_id"], :name => "statscvsgroup_month_day_group", :unique => true
  add_index "stats_cvs_group", ["oid"], :name => "statscvsgrp_oid", :unique => true

  create_table "stats_cvs_user", :id => false, :force => true do |t|
    t.integer "month",     :default => 0, :null => false
    t.integer "day",       :default => 0, :null => false
    t.integer "group_id",  :default => 0, :null => false
    t.integer "user_id",   :default => 0, :null => false
    t.integer "checkouts", :default => 0, :null => false
    t.integer "commits",   :default => 0, :null => false
    t.integer "adds",      :default => 0, :null => false
  end

  create_table "stats_project", :id => false, :force => true do |t|
    t.integer "month",            :default => 0, :null => false
    t.integer "day",              :default => 0, :null => false
    t.integer "group_id",         :default => 0, :null => false
    t.integer "file_releases",    :default => 0
    t.integer "msg_posted",       :default => 0
    t.integer "msg_uniq_auth",    :default => 0
    t.integer "bugs_opened",      :default => 0
    t.integer "bugs_closed",      :default => 0
    t.integer "support_opened",   :default => 0
    t.integer "support_closed",   :default => 0
    t.integer "patches_opened",   :default => 0
    t.integer "patches_closed",   :default => 0
    t.integer "artifacts_opened", :default => 0
    t.integer "artifacts_closed", :default => 0
    t.integer "tasks_opened",     :default => 0
    t.integer "tasks_closed",     :default => 0
    t.integer "help_requests",    :default => 0
  end

  add_index "stats_project", ["month", "day", "group_id"], :name => "statsproject_month_day_group", :unique => true
  add_index "stats_project", ["oid"], :name => "statsproject_oid", :unique => true

  create_table "stats_project_developers", :id => false, :force => true do |t|
    t.integer "month",      :default => 0, :null => false
    t.integer "day",        :default => 0, :null => false
    t.integer "group_id",   :default => 0, :null => false
    t.integer "developers", :default => 0, :null => false
  end

  add_index "stats_project_developers", ["month", "day", "group_id"], :name => "statsprojectdev_month_day_group", :unique => true
  add_index "stats_project_developers", ["oid"], :name => "statsprojectdevelop_oid", :unique => true

  create_table "stats_project_metric", :id => false, :force => true do |t|
    t.integer "month",      :default => 0,   :null => false
    t.integer "day",        :default => 0,   :null => false
    t.integer "ranking",    :default => 0,   :null => false
    t.float   "percentile", :default => 0.0, :null => false
    t.integer "group_id",   :default => 0,   :null => false
  end

  add_index "stats_project_metric", ["month", "day", "group_id"], :name => "statsprojectmetric_month_day_gr", :unique => true
  add_index "stats_project_metric", ["oid"], :name => "statsprojectmetric_oid", :unique => true

  create_table "stats_project_months", :id => false, :force => true do |t|
    t.integer "month"
    t.integer "group_id"
    t.integer "developers"
    t.integer "group_ranking"
    t.float   "group_metric"
    t.integer "logo_showings"
    t.integer "downloads"
    t.integer "site_views"
    t.integer "subdomain_views"
    t.integer "page_views"
    t.integer "file_releases"
    t.integer "msg_posted"
    t.integer "msg_uniq_auth"
    t.integer "bugs_opened"
    t.integer "bugs_closed"
    t.integer "support_opened"
    t.integer "support_closed"
    t.integer "patches_opened"
    t.integer "patches_closed"
    t.integer "artifacts_opened"
    t.integer "artifacts_closed"
    t.integer "tasks_opened"
    t.integer "tasks_closed"
    t.integer "help_requests"
    t.integer "cvs_checkouts"
    t.integer "cvs_commits"
    t.integer "cvs_adds"
  end

  add_index "stats_project_months", ["group_id", "month"], :name => "statsprojectmonths_groupid_mont"
  add_index "stats_project_months", ["group_id"], :name => "statsprojectmonths_groupid"

  create_table "stats_site", :id => false, :force => true do |t|
    t.integer "month"
    t.integer "day"
    t.integer "uniq_users"
    t.integer "sessions"
    t.integer "total_users"
    t.integer "new_users"
    t.integer "new_projects"
  end

  add_index "stats_site", ["month", "day"], :name => "statssite_month_day", :unique => true
  add_index "stats_site", ["oid"], :name => "statssite_oid", :unique => true

  create_table "stats_site_months", :id => false, :force => true do |t|
    t.integer "month"
    t.integer "site_page_views"
    t.integer "downloads"
    t.integer "subdomain_views"
    t.integer "msg_posted"
    t.integer "bugs_opened"
    t.integer "bugs_closed"
    t.integer "support_opened"
    t.integer "support_closed"
    t.integer "patches_opened"
    t.integer "patches_closed"
    t.integer "artifacts_opened"
    t.integer "artifacts_closed"
    t.integer "tasks_opened"
    t.integer "tasks_closed"
    t.integer "help_requests"
    t.integer "cvs_checkouts"
    t.integer "cvs_commits"
    t.integer "cvs_adds"
  end

  add_index "stats_site_months", ["month"], :name => "statssitemonths_month"

  create_table "stats_site_pages_by_day", :id => false, :force => true do |t|
    t.integer "month"
    t.integer "day"
    t.integer "site_page_views"
  end

  add_index "stats_site_pages_by_day", ["month", "day"], :name => "statssitepagesbyday_month_day"
  add_index "stats_site_pages_by_day", ["oid"], :name => "statssitepgsbyday_oid", :unique => true

  create_table "stats_site_pages_by_month", :id => false, :force => true do |t|
    t.integer "month"
    t.integer "site_page_views"
  end

  create_table "stats_subd_pages", :id => false, :force => true do |t|
    t.integer "month",    :default => 0, :null => false
    t.integer "day",      :default => 0, :null => false
    t.integer "group_id", :default => 0, :null => false
    t.integer "pages",    :default => 0, :null => false
  end

  add_index "stats_subd_pages", ["month", "day", "group_id"], :name => "statssubdpages_month_day_group", :unique => true
  add_index "stats_subd_pages", ["oid"], :name => "statssubdpages_oid", :unique => true

  create_table "supported_languages", :primary_key => "language_id", :force => true do |t|
    t.text   "name"
    t.text   "filename"
    t.text   "classname"
    t.string "language_code", :limit => 5
  end

  add_index "supported_languages", ["language_id"], :name => "supported_langu_language_id_key", :unique => true

  create_table "survey_question_types", :force => true do |t|
    t.text "type", :default => "", :null => false
  end

  create_table "survey_questions", :primary_key => "question_id", :force => true do |t|
    t.integer "group_id",      :default => 0,  :null => false
    t.text    "question",      :default => "", :null => false
    t.integer "question_type", :default => 0,  :null => false
  end

  add_index "survey_questions", ["group_id"], :name => "survey_questions_group"

  create_table "survey_rating_aggregate", :id => false, :force => true do |t|
    t.integer "type",     :default => 0, :null => false
    t.integer "id",       :default => 0, :null => false
    t.float   "response",                :null => false
    t.integer "count",    :default => 0, :null => false
  end

  add_index "survey_rating_aggregate", ["type", "id"], :name => "survey_rating_aggregate_type_id"

  create_table "survey_rating_response", :id => false, :force => true do |t|
    t.integer "user_id",   :default => 0, :null => false
    t.integer "type",      :default => 0, :null => false
    t.integer "id",        :default => 0, :null => false
    t.integer "response",  :default => 0, :null => false
    t.integer "post_date", :default => 0, :null => false
  end

  add_index "survey_rating_response", ["type", "id"], :name => "survey_rating_responses_type_id"
  add_index "survey_rating_response", ["user_id", "type", "id"], :name => "survey_rating_responses_user_ty"

  create_table "survey_responses", :id => false, :force => true do |t|
    t.integer "user_id",     :default => 0,  :null => false
    t.integer "group_id",    :default => 0,  :null => false
    t.integer "survey_id",   :default => 0,  :null => false
    t.integer "question_id", :default => 0,  :null => false
    t.text    "response",    :default => "", :null => false
    t.integer "post_date",   :default => 0,  :null => false
  end

  add_index "survey_responses", ["group_id"], :name => "survey_responses_group_id"
  add_index "survey_responses", ["survey_id", "question_id"], :name => "survey_responses_survey_questio"
  add_index "survey_responses", ["user_id", "survey_id", "question_id"], :name => "survey_responses_user_survey_qu"
  add_index "survey_responses", ["user_id", "survey_id"], :name => "survey_responses_user_survey"

  create_table "surveys", :primary_key => "survey_id", :force => true do |t|
    t.integer "group_id",         :default => 0,  :null => false
    t.text    "survey_title",     :default => "", :null => false
    t.text    "survey_questions", :default => "", :null => false
    t.integer "is_active",        :default => 1,  :null => false
  end

  add_index "surveys", ["group_id"], :name => "surveys_group"

  create_table "themes", :id => false, :force => true do |t|
    t.integer "theme_id",                                 :null => false
    t.string  "dirname",  :limit => 80
    t.string  "fullname", :limit => 80
    t.boolean "enabled",                :default => true
  end

  add_index "themes", ["theme_id"], :name => "themes_theme_id_key", :unique => true

  create_table "trove_agg", :id => false, :force => true do |t|
    t.integer "trove_cat_id"
    t.integer "group_id"
    t.string  "group_name",        :limit => 40
    t.string  "unix_group_name",   :limit => 30
    t.string  "status",            :limit => 1
    t.integer "register_time"
    t.string  "short_description"
    t.float   "percentile"
    t.integer "ranking"
  end

  add_index "trove_agg", ["trove_cat_id", "ranking"], :name => "troveagg_trovecatid_ranking"
  add_index "trove_agg", ["trove_cat_id"], :name => "troveagg_trovecatid"

  create_table "trove_cat", :primary_key => "trove_cat_id", :force => true do |t|
    t.integer "version",                     :default => 0,  :null => false
    t.integer "parent",                      :default => 0,  :null => false
    t.integer "root_parent",                 :default => 0,  :null => false
    t.string  "shortname",     :limit => 80
    t.string  "fullname",      :limit => 80
    t.string  "description"
    t.integer "count_subcat",                :default => 0,  :null => false
    t.integer "count_subproj",               :default => 0,  :null => false
    t.text    "fullpath",                    :default => "", :null => false
    t.text    "fullpath_ids"
  end

  add_index "trove_cat", ["parent"], :name => "parent_idx"
  add_index "trove_cat", ["root_parent"], :name => "root_parent_idx"
  add_index "trove_cat", ["version"], :name => "version_idx"

  create_table "trove_group_link", :primary_key => "trove_group_id", :force => true do |t|
    t.integer "trove_cat_id",      :default => 0, :null => false
    t.integer "trove_cat_version", :default => 0, :null => false
    t.integer "group_id",          :default => 0, :null => false
    t.integer "trove_cat_root",    :default => 0, :null => false
  end

  add_index "trove_group_link", ["group_id"], :name => "trove_group_link_group_id"
  add_index "trove_group_link", ["trove_cat_id"], :name => "trove_group_link_cat_id"

  create_table "trove_treesums", :primary_key => "trove_treesums_id", :force => true do |t|
    t.integer "trove_cat_id", :default => 0, :null => false
    t.integer "limit_1",      :default => 0, :null => false
    t.integer "subprojects",  :default => 0, :null => false
  end

  create_table "user_bookmarks", :primary_key => "bookmark_id", :force => true do |t|
    t.integer "user_id",        :default => 0, :null => false
    t.text    "bookmark_url"
    t.text    "bookmark_title"
  end

  add_index "user_bookmarks", ["user_id"], :name => "user_bookmark_user_id"

  create_table "user_diary", :force => true do |t|
    t.integer "user_id",     :default => 0, :null => false
    t.integer "date_posted", :default => 0, :null => false
    t.text    "summary"
    t.text    "details"
    t.integer "is_public",   :default => 0, :null => false
  end

  add_index "user_diary", ["date_posted"], :name => "user_diary_date"
  add_index "user_diary", ["user_id", "date_posted"], :name => "user_diary_user_date"
  add_index "user_diary", ["user_id"], :name => "user_diary_user"

  create_table "user_diary_monitor", :primary_key => "monitor_id", :force => true do |t|
    t.integer "monitored_user", :default => 0, :null => false
    t.integer "user_id",        :default => 0, :null => false
  end

  add_index "user_diary_monitor", ["monitored_user"], :name => "user_diary_monitor_monitored_us"
  add_index "user_diary_monitor", ["user_id"], :name => "user_diary_monitor_user"

  create_table "user_group", :primary_key => "user_group_id", :force => true do |t|
    t.integer "user_id",                      :default => 0,   :null => false
    t.integer "group_id",                     :default => 0,   :null => false
    t.string  "admin_flags",    :limit => 16, :default => "",  :null => false
    t.integer "forum_flags",                  :default => 0,   :null => false
    t.integer "project_flags",                :default => 2,   :null => false
    t.integer "doc_flags",                    :default => 0,   :null => false
    t.integer "cvs_flags",                    :default => 1,   :null => false
    t.integer "member_role",                  :default => 100, :null => false
    t.integer "release_flags",                :default => 0,   :null => false
    t.integer "artifact_flags"
    t.string  "sys_state",      :limit => 1,  :default => "N"
    t.string  "sys_cvs_state",  :limit => 1,  :default => "N"
    t.integer "role_id",                      :default => 1
  end

  add_index "user_group", ["admin_flags"], :name => "admin_flags_idx"
  add_index "user_group", ["forum_flags"], :name => "forum_flags_idx"
  add_index "user_group", ["group_id", "user_id"], :name => "usergroup_uniq_groupid_userid", :unique => true
  add_index "user_group", ["group_id"], :name => "user_group_group_id"
  add_index "user_group", ["project_flags"], :name => "project_flags_idx"
  add_index "user_group", ["user_id"], :name => "user_group_user_id"

  create_table "user_metric", :primary_key => "ranking", :force => true do |t|
    t.integer "user_id",               :default => 0, :null => false
    t.integer "times_ranked",          :default => 0, :null => false
    t.float   "avg_raters_importance",                :null => false
    t.float   "avg_rating",                           :null => false
    t.float   "metric",                               :null => false
    t.float   "percentile",                           :null => false
    t.float   "importance_factor",                    :null => false
  end

  create_table "user_metric0", :primary_key => "ranking", :force => true do |t|
    t.integer "user_id",               :default => 0, :null => false
    t.integer "times_ranked",          :default => 0, :null => false
    t.float   "avg_raters_importance",                :null => false
    t.float   "avg_rating",                           :null => false
    t.float   "metric",                               :null => false
    t.float   "percentile",                           :null => false
    t.float   "importance_factor",                    :null => false
  end

  add_index "user_metric0", ["user_id"], :name => "user_metric0_user_id"

  create_table "user_metric_history", :id => false, :force => true do |t|
    t.integer "month",   :null => false
    t.integer "day",     :null => false
    t.integer "user_id", :null => false
    t.integer "ranking", :null => false
    t.float   "metric",  :null => false
  end

  add_index "user_metric_history", ["month", "day", "user_id"], :name => "user_metric_history_date_userid"

  create_table "user_plugin", :primary_key => "user_plugin_id", :force => true do |t|
    t.integer "user_id"
    t.integer "plugin_id"
  end

  create_table "user_preferences", :id => false, :force => true do |t|
    t.integer "user_id",                        :default => 0, :null => false
    t.string  "preference_name",  :limit => 20
    t.integer "set_date",                       :default => 0, :null => false
    t.text    "preference_value"
  end

  add_index "user_preferences", ["user_id"], :name => "user_pref_user_id"

  create_table "user_ratings", :id => false, :force => true do |t|
    t.integer "rated_by",   :default => 0, :null => false
    t.integer "user_id",    :default => 0, :null => false
    t.integer "rate_field", :default => 0, :null => false
    t.integer "rating",     :default => 0, :null => false
  end

  add_index "user_ratings", ["rated_by"], :name => "user_ratings_rated_by"
  add_index "user_ratings", ["user_id"], :name => "user_ratings_user_id"

  create_table "user_session", :id => false, :force => true do |t|
    t.integer "user_id",                    :default => 0,  :null => false
    t.string  "session_hash", :limit => 32, :default => "", :null => false
    t.string  "ip_addr",      :limit => 15, :default => "", :null => false
    t.integer "time",                       :default => 0,  :null => false
  end

  add_index "user_session", ["time"], :name => "session_time"
  add_index "user_session", ["user_id"], :name => "session_user_id"

  create_table "user_type", :id => false, :force => true do |t|
    t.integer "type_id",   :null => false
    t.text    "type_name"
  end

  add_index "user_type", ["type_id"], :name => "user_type_type_id_key", :unique => true

  create_table "users", :primary_key => "user_id", :force => true do |t|
    t.text    "user_name",                        :default => "",          :null => false
    t.text    "email",                            :default => "",          :null => false
    t.string  "user_pw",            :limit => 32, :default => "",          :null => false
    t.string  "realname",           :limit => 32, :default => "",          :null => false
    t.string  "status",             :limit => 1,  :default => "A",         :null => false
    t.string  "shell",              :limit => 20, :default => "/bin/bash", :null => false
    t.string  "unix_pw",            :limit => 40, :default => "",          :null => false
    t.string  "unix_status",        :limit => 1,  :default => "N",         :null => false
    t.integer "unix_uid",                         :default => 0,           :null => false
    t.string  "unix_box",           :limit => 10, :default => "shell1",    :null => false
    t.integer "add_date",                         :default => 0,           :null => false
    t.string  "confirm_hash",       :limit => 32
    t.integer "mail_siteupdates",                 :default => 0,           :null => false
    t.integer "mail_va",                          :default => 0,           :null => false
    t.text    "authorized_keys"
    t.text    "email_new"
    t.integer "people_view_skills",               :default => 0,           :null => false
    t.text    "people_resume",                    :default => "",          :null => false
    t.string  "timezone",           :limit => 64, :default => "GMT"
    t.integer "language",                         :default => 1,           :null => false
    t.integer "block_ratings",                    :default => 0
    t.text    "jabber_address"
    t.integer "jabber_only"
    t.text    "address"
    t.text    "phone"
    t.text    "fax"
    t.text    "title"
    t.integer "theme_id"
    t.string  "firstname",          :limit => 60
    t.string  "lastname",           :limit => 60
    t.text    "address2"
    t.string  "ccode",              :limit => 2,  :default => "US"
    t.string  "sys_state",          :limit => 1,  :default => "N"
    t.integer "type_id",                          :default => 1
  end

  add_index "users", ["status"], :name => "users_status"
  add_index "users", ["user_name"], :name => "users_namename_uniq", :unique => true
  add_index "users", ["user_pw"], :name => "users_user_pw"

end
