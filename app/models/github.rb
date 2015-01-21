class Github

  def self.stack
    @stack ||= Faraday::RackBuilder.new do |builder|
      options = { store: Rails.cache, logger: Rails.logger, serializer: Yajl }
      builder.use Faraday::HttpCache, options
      builder.use Octokit::Response::RaiseError
      builder.adapter Faraday.default_adapter
    end
  end

  def self.client(user = nil)
    if user
      config = {
                access_token: user.token,
               }
    else
      config = {
                client_id: ENV['GITHUB_CLIENT_ID'],
                client_secret: ENV['GITHUB_CLIENT_SECRET'],
               }
    end
    Octokit.middleware = stack
    Octokit.auto_paginate = true
    Octokit::Client.new(config)
  end

  def self.rate_limit
    client.rate_limit
  end
end
