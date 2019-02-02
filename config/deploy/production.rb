set :repo_url, 'https://github.com/ub/diaspora.git'
# set :branch, 'master'
set :branch, 'solidarnost-dev'

set :git_shallow_clone, 1

role :web, %w{production.solidarnost.local}
role :app, %w{production.solidarnost.local}
role :db,  %w{production.solidarnost.local}

ssh_options = {
  keys: %w(ssh_keys/diaspora),
  forward_agent: true,
  auth_methods: %w(publickey password)
}


#
set :rails_env, 'production'

server 'production.solidarnost.local', user: 'diaspora', roles: %w{web app db}, ssh_options: ssh_options

