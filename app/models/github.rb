class Github
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
    @client ||= Octokit::Client.new(config).tap { |client|
      Octokit.auto_paginate = true
    }
  end

  def self.rate_limit
    client.rate_limit
  end
end
