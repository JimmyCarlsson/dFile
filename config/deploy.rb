# config valid only for current version of Capistrano
set :application, 'dFile'
set :repo_url, 'https://github.com/ub-digit/dFile.git'

set :rvm_ruby_version, '2.3.1'      # Defaults to: 'default'

# Returns config for current stage assigned in config/deploy.yml
def deploy_config
  @config ||= YAML.load_file("config/deploy.yml")
  stage = fetch(:stage)
  return @config[stage.to_s]
end

# Copied into /{app}/shared/config from respective sample file
set :linked_files, ['config/initializers/config.rb', 'config/redis.yml']

server deploy_config['host'], user: deploy_config['user'], roles: ['app', 'db', 'web'], port: deploy_config['port']

set :deploy_to, deploy_config['path']
