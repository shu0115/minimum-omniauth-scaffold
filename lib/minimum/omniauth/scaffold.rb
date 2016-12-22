require "minimum/omniauth/scaffold/version"
require 'rails/generators'
require 'config'
require 'omniauth-twitter'
require 'omniauth-facebook'
require 'omniauth-github'
require 'tapp'
require 'awesome_print'

module Minimum
  module Omniauth
    class ScaffoldGenerator < Rails::Generators::Base
      @@template_path = source_root File.expand_path("../scaffold/templates", __FILE__)
      @@current_path  = Dir.pwd

      def generate_scaffold
        app_name = Rails.application.class.name.split('::').first

        # rails_config
        copy_file "#{@@template_path}/rails_config/config.rb", "config/initializers/config.rb"
        copy_file "#{@@template_path}/rails_config/settings.yml", "config/settings.yml"
        copy_file "#{@@template_path}/rails_config/settings.local.yml", "config/settings.local.yml"
        copy_file "#{@@template_path}/rails_config/development.yml", "config/settings/development.yml"
        copy_file "#{@@template_path}/rails_config/production.yml", "config/settings/production.yml"
        copy_file "#{@@template_path}/rails_config/test.yml", "config/settings/test.yml"

        # omniauth
        copy_file "#{@@template_path}/initializers/omniauth.rb", "config/initializers/omniauth.rb"

        # routes.rb
        content = "\n  # For OmniAuth\n"
        content += "  get '/auth/:provider/callback', to: 'sessions#callback'\n"
        content += "  get '/auth/failure',            to: 'sessions#failure'\n"
        content += "  get '/logout',                  to: 'sessions#destroy', as: :logout\n"
        content += "\n"
        insert_into_file "config/routes.rb", content.force_encoding('ASCII-8BIT'), after: "Rails.application.routes.draw do\n"
        insert_into_file "config/routes.rb", "  root to: 'top#index'\n", after: "Rails.application.routes.draw do\n"

        # ja.yml
        copy_file "#{@@template_path}/locales/ja.yml", "config/locales/ja.yml"
        copy_file "#{@@template_path}/locales/translation_ja.yml", "config/locales/translation_ja.yml"

        # migration
        # copy_file "#{@@template_path}/migrate/create_users.rb", "db/migrate/20000101000000_create_users.rb"
        # copy_file "#{@@template_path}/migrate/create_authentications.rb", "db/migrate/20000102000000_create_authentications.rb"
        copy_file "#{@@template_path}/migrate/Schemafile", "Schemafile"

        # models
        copy_file "#{@@template_path}/models/user.rb", "app/models/user.rb"
        copy_file "#{@@template_path}/models/authentication.rb", "app/models/authentication.rb"

        # controllers
        content = File.read("#{@@template_path}/controllers/application_controller.rb", encoding: Encoding::UTF_8)
        insert_into_file "app/controllers/application_controller.rb", content.force_encoding('ASCII-8BIT'), after: "protect_from_forgery with: :exception\n"
        copy_file "#{@@template_path}/controllers/sessions_controller.rb", "app/controllers/sessions_controller.rb"
        copy_file "#{@@template_path}/controllers/top_controller.rb", "app/controllers/top_controller.rb"

        # views
        # content = File.read( "#{@@template_path}/views/application.html.erb", encoding: Encoding::UTF_8 )
        # gsub_file "app/views/layouts/application.html.erb", /(<%= yield %>)+/, content.force_encoding('ASCII-8BIT')
        # gsub_file "app/views/layouts/application.html.erb", Regexp.new("<title>#{app_name}</title>"), "<title><%= Settings.app_name %></title>"

        begin
          copy_file "#{@@current_path}/app/views/layouts/application.html.erb", 'app/views/layouts/application_BACKUP.html.erb'
          remove_file "#{@@current_path}/app/views/layouts/application.html.erb"
        rescue => e
          e.tapp
        end

        copy_file "#{@@template_path}/views/application.html.haml", 'app/views/layouts/application.html.haml'
        copy_file "#{@@template_path}/views/_user_icon.html.haml", "app/views/layouts/_user_icon.html.haml"
        copy_file "#{@@template_path}/views/index.html.haml", "app/views/top/index.html.haml"

        # assets
        copy_file "#{@@template_path}/stylesheets/scaffolds.css.scss", "app/assets/stylesheets/scaffolds.css.scss"

        # # README
        # begin
        #   copy_file "#{@@current_path}/README.md", 'README_BACKUP.md'
        #   remove_file "#{@@current_path}/README.md"
        # rescue => e
        #   e.tapp
        # end
        # copy_file "#{@@template_path}/README.md", "README.md"

        # .gitignore
        content = "\n# Add\n"
        content += ".DS_Store\n"
        content += "vendor/bundle\n"
        content += "/log/*.log.*\n"
        content += "\n# rails_config\n"
        content += "config/settings.local.yml\n"
        content += "config/settings/*.local.yml\n"
        content += "config/environments/*.local.yml\n"
        append_file ".gitignore", content.force_encoding('ASCII-8BIT')
      end
    end
  end
end
