require 'erb'

set :application, "scrubyconf"

role :app, "amcates.net"
role :web, "amcates.net"
role :db,  "amcates.net", :primary => true

set :deploy_to, "/var/www/vhosts/colaruby.com/subdomains/scrubyconf"
set :use_sudo, false
set :app_port, "8008"
set :rails_env, "production"

set :scm, :git
set :repository, "git@github-scruby:amcates/scruby.git"

desc "Make sure groups and permissions are set correctly"
task :after_setup do
#  run "chown -R apache:apache #{deploy_to}"
#  run "find #{deploy_to} -type d -exec chmod 770 '{}' \\;"
#  run "find #{deploy_to} -type f -exec chmod 660 '{}' \\;"
end

before "deploy:setup", :db
after "deploy:update_code", "db:symlink"

namespace :db do
  desc "Create database yaml in shared path"
  task :default do
    db_config = ERB.new <<-EOF
production:
  database: #{application}_production
  adapter: mysql
  host: localhost
  username: scrubyconf
  password: F3aRmI$QeL
    EOF

    thin_config = ERB.new <<-EOF
--- 
  port: #{app_port}
  environment: #{rails_env}
  servers: 1
  address: 127.0.0.1
  chdir: #{deploy_to}/current
  log: #{shared_path}/log/thin.log
  pid: #{shared_path}/pids/thin.pid
  timeout: 30
  max_conns: 1024
  max_persistent_conns: 512
  daemonize: true
    EOF

    run "mkdir -p #{shared_path}/config"
    put db_config.result, "#{shared_path}/config/database.yml"
    put thin_config.result, "#{shared_path}/config/thin.yml"
  end

  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/thin.yml #{release_path}/config/thin.yml"
  end
end

namespace :deploy do

  desc "Restart thin"
  task :restart do
    deploy.stop
    deploy.start
  end

  desc "Start thin"
  task :start do
    run "thin start -C #{shared_path}/config/thin.yml"
  end

  desc "Stop thin"
  task :stop do
    run "thin stop  -C #{shared_path}/config/thin.yml"
  end

end
