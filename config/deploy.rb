set :application, "api"
set :repository,  "file:///var/svn/#{application}/trunk/"
set :local_repository, "svn+ssh://rubyforge.org/var/svn/#{application}/trunk"

set :deploy_to, "/var/www/gforge-projects/api/"
set :copy_strategy, :export
set :user,  "tom"
set :group, "api"
set :runner, "tom"
set :use_sudo, false

server "rubyforge.org", :app, :web
role :db, "rubyforge.org", :primary => true

def run_remote_rake(rake_cmd)
  run "cd #{current_path} && /usr/local/bin/rake RAILS_ENV=production #{rake_cmd}"
end

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end

task :move_in_database_yml, :roles => :app do
  run "cp #{deploy_to}/shared/system/database.yml #{current_path}/config/"
end

after "deploy:symlink", "move_in_database_yml"
#after "deploy", "deploy:migrate"
#after "deploy", "deploy:cleanup"

desc "Tail the production log"
task :tail, :roles => :app do
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end
