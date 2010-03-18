##
## REMEMBER: you can see available tasks with "cap -T"
##

##
## Items to configure
##

set :application, "oneaim"
set :user, "oneaim"

set :repository, "/var/git/repositories/oneaim.git"
set :branch, "master"

set :deploy_host, '0xb5.org'

##
## Items you should probably leave alone
##

set :scm, "git"
set :local_repository, "#{File.dirname(__FILE__)}/../"

set :deploy_via, :remote_cache

# as an alternative, if you server does NOT have direct git access to the,
# you can deploy_via :copy, which will build a tarball locally and upload
# it to the deploy server.
#set :deploy_via, :copy
set :copy_strategy, :checkout
set :copy_exclude, [".git"]

set :git_shallow_clone, 1  # only copy the most recent, not the entire repository (default:1)
set :git_enable_submodules, 0
set :keep_releases, 3

ssh_options[:paranoid] = false
set :use_sudo, false

role :web, deploy_host
role :app, deploy_host
role :db, deploy_host, :primary=>true

set :deploy_to, "/var/rails/#{application}"


##
## CUSTOM TASKS
##

namespace :passenger do
  desc "Restart rails application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end

  # requires root
  desc "Check memory stats"
  task :memory do
    sudo "passenger-memory-stats"
  end

  # requires root
  desc "Check status of rails processes"
  task :status do
    sudo "passenger-status"
  end
end

namespace :oneaim do
  task :create_shared, :roles => :app do
    run "mkdir -p #{deploy_to}/#{shared_dir}/tmp/sessions"
    run "mkdir -p #{deploy_to}/#{shared_dir}/tmp/cache"
    run "mkdir -p #{deploy_to}/#{shared_dir}/tmp/sockets"
    run "mkdir -p #{deploy_to}/#{shared_dir}/logs"
    run "mkdir -p #{deploy_to}/#{shared_dir}/config"
  end

  task :link_to_shared do
    run "rm -rf #{current_release}/tmp"
    run "ln -nfs #{shared_path}/tmp #{current_release}/tmp"
    run "rm -rf #{current_release}/log"
    run "ln -nfs #{shared_path}/log #{current_release}/log"
    run "rm -f #{current_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{current_release}/config/"
  end
end

after  "deploy:setup",   "oneaim:create_shared"
after  "deploy:symlink", "oneaim:link_to_shared"
after  "deploy:restart", "passenger:restart"

