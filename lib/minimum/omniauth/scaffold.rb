require "minimum/omniauth/scaffold/version"

require 'rails/generators'

require 'rails_config'
require 'omniauth-twitter'
require 'omniauth-facebook'
require 'omniauth-github'
require 'tapp'
require 'awesome_print'

module Minimum
  module Omniauth
    class ScaffoldGenerator < Rails::Generators::Base
      @@template_path = source_root File.expand_path( "../scaffold/templates", __FILE__ )

      def generate_scaffold
        app_name = Rails.application.class.name.split('::').first

        # ----- rails_config ----- #
        copy_file( "#{@@template_path}/rails_config/rails_config.rb", "config/initializers/rails_config.rb" )
        copy_file( "#{@@template_path}/rails_config/settings.yml", "config/settings.yml" )
        copy_file( "#{@@template_path}/rails_config/settings.local.yml", "config/settings.local.yml" )
        copy_file( "#{@@template_path}/rails_config/development.yml", "config/settings/development.yml" )
        copy_file( "#{@@template_path}/rails_config/production.yml", "config/settings/production.yml" )
        copy_file( "#{@@template_path}/rails_config/test.yml", "config/settings/test.yml" )

        # ----- omniauth ----- #
        copy_file( "#{@@template_path}/initializers/omniauth.rb", "config/initializers/omniauth.rb" )

        # ----- routes.rb ----- #
        content = "\n  # For OmniAuth\n"
        content += "  get \"/auth/:provider/callback\" => \"sessions#callback\"\n"
        content += "  get \"/auth/failure\" => \"sessions#failure\"\n"
        content += "  get \"/logout\" => \"sessions#destroy\", :as => :logout\n"
        content += "\n"
        insert_into_file( "config/routes.rb", content.force_encoding('ASCII-8BIT'), after: "Rails4sample::Application.routes.draw do\n" )
        insert_into_file( "config/routes.rb", "  root to: 'top#index'\n", after: "Rails4sample::Application.routes.draw do\n" )
#        insert_into_file( "config/routes.rb", "  match ':controller(/:action(/:id))(.:format)'\n", after: "# match ':controller(/:action(/:id))(.:format)'\n" )

        # ----- application.rb ----- #
        content = "    config.time_zone = 'Tokyo'\n"
#        content += "    config.active_record.default_timezone = :local\n"
        insert_into_file( "config/application.rb", content.force_encoding('ASCII-8BIT'), after: "# config.time_zone = 'Central Time (US & Canada)'\n" )
        insert_into_file( "config/application.rb", "    config.i18n.default_locale = :ja\n", after: "# config.i18n.default_locale = :de\n" )
        content = "\n    # For Heroku\n"
        content += "    config.assets.initialize_on_precompile = false\n"
        content += "\n    # For Tapp\n"
        content += "    Tapp.config.default_printer = :awesome_print\n"
        insert_into_file( "config/application.rb", content.force_encoding('ASCII-8BIT'), after: "config.assets.version = '1.0'\n" )

        # ----- production.rb ----- #
        insert_into_file( "config/environments/production.rb", "  config.force_ssl = true\n", after: "# config.force_ssl = true\n" )  # 強制SSL設定

        # ----- development.rb ----- #
        content = "\n  # For LogRotate\n"
        content += "  config.logger = Logger.new( 'log/development.log', 3, 10*1024*1024 )  # 10MB * 3\n"
        insert_into_file( "config/environments/development.rb", content.force_encoding('ASCII-8BIT'), after: "config.assets.debug = true\n" )
        gsub_file "config/environments/development.rb", /(config.assets.debug = true)+/, "# config.assets.debug = true"  # コメントアウト追加
        insert_into_file( "config/environments/development.rb", "  config.assets.debug = false\n", after: "config.assets.debug = true\n" )  # false設定追加

        # ----- ja.yml ----- #
        copy_file( "#{@@template_path}/locales/ja.yml", "config/locales/ja.yml" )
        copy_file( "#{@@template_path}/locales/translation_ja.yml", "config/locales/translation_ja.yml" )

        # ----- create_users.rb ----- #
        copy_file( "#{@@template_path}/migrate/create_users.rb", "db/migrate/20000101000000_create_users.rb" )

        # ----- models ----- #
        copy_file( "#{@@template_path}/models/user.rb", "app/models/user.rb" )

        # ----- controllers ----- #
        content = File.read( "#{@@template_path}/controllers/application_controller.rb", encoding: Encoding::UTF_8 )
#        gsub_file "app/controllers/application_controller.rb", /(class ApplicationController < ActionController::Base\n  protect_from_forgery\nend\n)+/, content.force_encoding('ASCII-8BIT')
        insert_into_file( "app/controllers/application_controller.rb", content.force_encoding('ASCII-8BIT'), after: "protect_from_forgery with: :exception\n" )
        copy_file( "#{@@template_path}/controllers/sessions_controller.rb", "app/controllers/sessions_controller.rb" )
        copy_file( "#{@@template_path}/controllers/top_controller.rb", "app/controllers/top_controller.rb" )

        # ----- views ----- #
        content = File.read( "#{@@template_path}/views/application.html.erb", encoding: Encoding::UTF_8 )
        gsub_file "app/views/layouts/application.html.erb", /(<%= yield %>)+/, content.force_encoding('ASCII-8BIT')
        gsub_file "app/views/layouts/application.html.erb", Regexp.new("<title>#{app_name}</title>"), "<title><%= Settings.app_name %></title>"
        copy_file( "#{@@template_path}/views/_user_icon.html.erb", "app/views/layouts/_user_icon.html.erb" )
        copy_file( "#{@@template_path}/views/index.html.erb", "app/views/top/index.html.erb" )

        # ----- assets ----- #
#          copy_file( "#{@@template_path}/base.css.scss", "app/assets/stylesheets/base.css.scss" )
        copy_file( "#{@@template_path}/stylesheets/scaffolds.css.scss", "app/assets/stylesheets/scaffolds.css.scss" )
#          copy_file( "#{@@template_path}/z_style.css.scss", "app/assets/stylesheets/z_style.css.scss" )

        # ----- public ----- #
#          remove_file( 'public/index.html' )

        # ----- README ----- #
        remove_file( 'README.rdoc' )
        copy_file( "#{@@template_path}/README.md", "README.md" )

        # ----- .gitignore ----- #
        content = "\n# Add\n"
        content += ".DS_Store\n"
        content += "vendor/bundle\n"
        content += "/log/*.log.*\n"
        content += "\n# rails_config\n"
        content += "config/settings.local.yml\n"
        content += "config/settings/*.local.yml\n"
        content += "config/environments/*.local.yml\n"
        append_file( ".gitignore", content.force_encoding('ASCII-8BIT') )
      end
    end
  end
end
