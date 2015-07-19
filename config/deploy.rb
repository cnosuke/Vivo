# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'vivo'
set :repo_url, 'git@github.com:cnosuke/vivo.git'
# ask :branch, 'master'

set :deploy_to, ENV['CAP_DEPLOY_TO']

set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push('.env', 'config/secrets.yml')

set :keep_releases, 5

set :exec_dotenv, 'bundle exec dotenv'

namespace :deploy do
  after :publishing, :restart do
    invoke 'unicorn:restart'
  end

  after :publishing, :migrate do
    on roles(:db) do
      execute "cd #{fetch(:deploy_to)}/current && #{fetch(:rbenv_prefix)} #{fetch(:exec_dotenv)} bundle exec ridgepole -E #{fetch(:stage)} -c config/database.yml --apply"
    end
  end

  after :publishing, :export do
    on roles(:db) do
      execute "cd #{fetch(:deploy_to)}/current && #{fetch(:rbenv_prefix)} #{fetch(:exec_dotenv)} bundle exec ridgepole -E #{fetch(:stage)} -c config/database.yml --export -o Schemafile"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end


# Default deploy_to directory is /var/www/my_app_name

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
