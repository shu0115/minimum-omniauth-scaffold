# Minimum::Omniauth::Scaffold

For Ruby2.0+ and Rails4.0.0+

## Installation

Add this line to your application's Gemfile:

```
gem 'minimum-omniauth-scaffold'
```

And then execute:

```
bundle
```

Or install it yourself as:

```
gem install minimum-omniauth-scaffold
```

## Usage

```
rails g minimum:omniauth:scaffold
----------
      create  config/initializers/rails_config.rb
      create  config/settings.yml
      create  config/settings.local.yml
      create  config/settings/development.yml
      create  config/settings/production.yml
      create  config/settings/test.yml
      create  config/initializers/omniauth.rb
      insert  config/routes.rb
      insert  config/routes.rb
      insert  config/application.rb
      insert  config/application.rb
      insert  config/application.rb
      insert  config/environments/production.rb
      insert  config/environments/development.rb
        gsub  config/environments/development.rb
      insert  config/environments/development.rb
      create  config/locales/ja.yml
      create  config/locales/translation_ja.yml
      create  db/migrate/20000101000000_create_users.rb
      create  app/models/user.rb
      insert  app/controllers/application_controller.rb
      create  app/controllers/sessions_controller.rb
      create  app/controllers/top_controller.rb
        gsub  app/views/layouts/application.html.erb
        gsub  app/views/layouts/application.html.erb
      create  app/views/layouts/_user_icon.html.erb
      create  app/views/top/index.html.erb
      create  app/assets/stylesheets/scaffolds.css.scss
      remove  README.rdoc
      create  README.md
      append  .gitignore
----------
```

```
rake db:migrate
```

### キー作成

* Twitter
  * [Create an application | Twitter Developers](https://dev.twitter.com/apps/new)
  * ※必須マークが無いが 「Callback URL」も入力必要

* Facebook
  * [Facebook Developers](https://developers.facebook.com/apps)
  * ※「新しいアプリを作成」作成後「Facebookでログインするウェブサイト」に「http://0.0.0.0:3000/」を入力

* GitHub
  * [New OAuth Application](https://github.com/settings/applications/new)
  * ※Main URL／Callback URL：「http://0.0.0.0:3000/」

config/settings.local.yml

```yaml
# Twitter OAuth Local Setting
twitter_key:    "Consumer key"
twitter_secret: "Consumer secret"

# Facebook OAuth Setting
facebook_app_id:     "アプリID / APIキー"
facebook_app_secret: "アプリのシークレットキー"

# GitHub OAuth Setting
github_client_id: "Client ID"
github_secret:    "Client Secret"
```

## Heroku環境変数設定

* Twitter

```
heroku config:set TWITTER_KEY=xxxxxxxxxx TWITTER_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

* Facebook

```
heroku config:set FACEBOOK_APP_ID=xxxxxxxxxx FACEBOOK_APP_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

* GitHub

```
heroku config:set GITHUB_CLIENT_ID=xxxxxxxxxx GITHUB_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
