Rails.application.config.middleware.use OmniAuth::Builder do
  # Providers
#  provider :developer unless Rails.env.production?
  provider :twitter,  Settings.twitter_key,      Settings.twitter_secret
  provider :facebook, Settings.facebook_app_id,  Settings.facebook_app_secret
  provider :github,   Settings.github_client_id, Settings.github_secret
end
