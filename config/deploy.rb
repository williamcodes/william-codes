require 'bundler/capistrano' # for bundler support

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

set :application, "william-codes"
set :repository,  "git@github.com:williamcodes/william-codes.git"

set :user, 'william'
set :deploy_to, "/home/#{ user }/#{ application }"
set :use_sudo, false

set :scm, :git

default_run_options[:pty] = true

set :rails_env, "production"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "162.243.111.146"                          # Your HTTP server, Apache/etc
role :app, "162.243.111.146"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_keys, :roles => :app do
    run "ln -nfs /home/#{user}/#{application}/shared/application.yml #{release_path}/config/application.yml"
    run "ln -nfs /home/#{user}/#{application}/shared/production.sqlite3 #{release_path}/db/production.sqlite3"
  end
end


namespace :db do
  task :migrate do
    run "cd #{release_path} && #{try_sudo} bundle exec rake db:migrate RAILS_ENV=production"
  end
end

before "deploy:finalize_update", "deploy:symlink_keys"
# before "deploy:restart", "db:migrate"

