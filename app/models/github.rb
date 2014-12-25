class Github
  def self.client
    @client ||= Octokit::Client.new(client_id: ENV['GITHUB_CLIENT_ID'],
                                    client_secret: ENV['GITHUB_CLIENT_SECRET'] )
  end

  def self.rate_limit
    client.rate_limit
  end
end
