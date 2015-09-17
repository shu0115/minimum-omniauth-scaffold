# https://github.com/railsconfig/config#working-with-heroku
Config.setup do |config|
  config.const_name = 'Settings'
  config.use_env    = true
end
