set :repo_url, 'https://github.com/ub/diaspora.git'
# set :branch, 'master'
set :branch, 'solidarnost-master'

set :git_shallow_clone, 1

role :web, %w{solidarno.st}
role :app, %w{solidarno.st}
role :db,  %w{solidarno.st}

ssh_options = {
  keys: %w(ssh_keys/solidarnost),
  forward_agent: true,
  auth_methods: %w(publickey password)
}


set :rails_env, 'production'

server 'solidarno.st', user: 'diaspora', roles: %w{web app db}, ssh_options: ssh_options

