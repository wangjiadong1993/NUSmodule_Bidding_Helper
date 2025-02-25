# config valid only for Capistrano 3.1
lock '3.1.0'
set :application, 'NUSmodule_Bidding_Helper'
set :repo_url, 'git@github.com:wangjiadong1993/NUSmodule_Bidding_Helper.git'
# set :deploy_to, '/home/deploy/apps/NUSmodule_Bidding_Helper'
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
#git@github.com:wangjiadong1993/NUSmodule_Bidding_Helper.git
# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/NUSmodule'

set :user, "jiadong"
# Default value for :scm is :git
set :scm, :git
set :branch, 'master'
# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true
set :ssh_options,   {:forward_agent => true }
# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :default_env, { path: "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" }
# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :puma_rackup, -> { File.join(current_path, 'config.ru') }
# set :puma_state, "#{shared_path}/tmp/pids/puma.state"
# set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
# set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
# set :puma_conf, "#{shared_path}/puma.rb"
# set :puma_access_log, "#{shared_path}/log/puma_error.log"
# set :puma_error_log, "#{shared_path}/log/puma_access.log"
# set :puma_role, :app
# set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
# set :puma_threads, [0, 16]
# set :puma_workers, 0
# set :puma_init_active_record, true
# set :puma_preload_app, true
# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

namespace :rails do
  desc "Open the rails console on each of the remote servers"
  task :console do
    on roles(:app) do |host| #does it for each host, bad.
      rails_env = fetch(:stage)
      execute_interactively "ruby #{current_path}/script/rails console #{rails_env}"  
    end
  end
 
  desc "Open the rails dbconsole on each of the remote servers"
  task :dbconsole do
    on roles(:db) do |host| #does it for each host, bad.
      rails_env = fetch(:stage)
      execute_interactively "ruby #{current_path}/script/rails dbconsole #{rails_env}"  
    end
  end
 
  def execute_interactively(command)
    user = fetch(:user)
    port = fetch(:port) || 22
    exec "ssh -l #{user} #{host} -p #{port} -t 'cd #{deploy_to}/current && #{command}'"
  end
end
