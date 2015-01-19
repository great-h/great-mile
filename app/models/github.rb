class Github
  def self.client
    @client ||= Octokit::Client.new(client_id: ENV['GITHUB_CLIENT_ID'],
                                    client_secret: ENV['GITHUB_CLIENT_SECRET'] ).tap { |client|
      Octokit.auto_paginate = true
    }
  end

  def self.rate_limit
    client.rate_limit
  end
end
