set :application, 'diaspora'

set :deploy_to, '/home/diaspora'

set :format, :pretty
set :log_level, :debug

set :linked_files, %w{config/database.yml config/diaspora.yml config/secrets.yml config/initializers/secret_token.rb}
set :linked_dirs, %w{ log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :keep_releases, 5

set :default_env, { DB: 'postgres' } # 'all' ?
set :bundle_flags, "--with  postgresql --deployment"

# for capistano-db-tasks
set :compressor, :bzip2

namespace :deploy do
  # before 'deploy:assets:precompile', 'diaspora:secret_token'
  after :finishing, 'deploy:cleanup'
end
