Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
    config.path_prefix = '/login'
  end
  provider :developer unless Rails.env.production?
  scope = "public_repo"
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: scope
end
