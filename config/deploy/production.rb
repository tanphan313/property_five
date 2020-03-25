set :user, :deploy
set :stage, :production
set :deploy_via, :remote_cache
set :rails_env, :production
server "103.77.160.66", port: 22, roles: [:web, :app, :db], primary: true

set :ssh_options, {
  user: fetch(:user),
  keys: %w(~/.ssh/deploy_property_five.pem),
  forward_agent: true,
  auth_methods: %w(publickey)
}
