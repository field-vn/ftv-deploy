# config valid only for current version of Capistrano
lock "3.16.0"

set :use_sudo, true

#set :application, 'hirusyoku'

# set :repo_url, proc { "git@github.com:jazttijaztti/medical-record-k1.git" }
set :repo_url, proc { ENV["git_source"] }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, ENV["branch"] || "develop"

# Default deploy_to directory is /var/www/my_app_name
#set :deploy_to, proc { "/var/www/html/#{fetch(:application)}" }

# Default value for :format is :airbrussh.
set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
time = Time.now;
set :format_options, command_output: true, log_file: "logs/#{time.strftime('%Y-%m-%d')}.#{fetch(:stage).split(':').reverse[0]}.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, ".env"

# Default value for linked_dirs is []
append :linked_dirs, "storage", "vendor", "public/uploads"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

SSHKit.config.command_map[:chmod] = "sudo chmod"
SSHKit.config.command_map[:chgrp] = "sudo chgrp"
SSHKit.config.command_map[:chown] = "sudo chown"
#SSHKit.config.command_map[:supervisord] = "sudo service supervisord"

if ENV["VIA_BASTION"]
  require "net/ssh/proxy/command"

  # Use a default host for the bastion, but allow it to be overridden
  bastion_host = ENV["BASTION_HOST"] || "1.1.1.1"

  # Use the local username by default
  bastion_user = ENV["BASTION_USER"] || "ec2-user"

  # Configure Capistrano to use the bastion host as a proxy
  ssh_command = "ssh -W %h:%p #{bastion_user}@#{bastion_host}"

  set :ssh_options, proxy: Net::SSH::Proxy::Command.new(ssh_command)
end

namespace :deploy do
    before "symlink:release", "composer:install"
    before "symlink:release", "composer:dump_autoload"
    before "symlink:release", "laravel:permissions"
    before "symlink:release", "laravel:clear_cache"
    before "symlink:release", "laravel:clear_config"
    before "symlink:release", "laravel:migrate"
    before "symlink:release", "laravel:queue_restart"
    before "symlink:release", "laravel:storage_link"

    #if fetch(:stage).split(':').reverse[1] === "hirusyoku"
      before "symlink:release", "yarn:install"
      before "symlink:release", "yarn:production"
      #after :finished, "supervisord:reload"
    #end

    # Set correct permissions for all files and directories
    after :finishing, 'permissions:set'

    before :cleanup, :cleanup_set_sudo

    desc 'Set permissions on old releases before cleanup'
    task :cleanup_set_sudo do
      set :use_sudo, true
    end

    after :finished, :cleanup
end
