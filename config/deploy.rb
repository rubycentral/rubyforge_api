require 'mongrel_cluster/recipes'

set :application, "api"

set :scm, :git
set :repository,  "git://rubyforge.org/api.git"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :deploy_to, "/var/www/gforge-projects/api/"

set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"
set :use_sudo, false
set :user,  "tom"
set :group, "api"
set :runner, "tom"

server "rubyforge.org", :app, :web
role :db, "rubyforge.org", :primary => true

task :move_in_database_yml, :roles => :app do
  run "cp #{deploy_to}/shared/system/database.yml #{current_path}/config/"
end

#after "deploy", "deploy:migrate"
after "deploy:symlink", "move_in_database_yml"
after "deploy", "deploy:cleanup"

desc "Tail the production log"
task :tail, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end
