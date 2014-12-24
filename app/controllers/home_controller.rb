class HomeController < ApplicationController
  def index
    repo_name = "great-h/great-h.github.io"
    @issues = issues_filter_milestone(repo_name,milestone_name)
    Rails.logger.info(client.rate_limit.to_s)
  end

  private
  def milestone_name
    Date.today.beginning_of_week(:wednesday).strftime("%Y%m%d")
  end

  def client
    @client ||= Octokit::Client.new(client_id: ENV["GITHUB_CLIENT_ID"],
                                    client_secret: ENV["GITHUB_CLIENT_SECRET"] )
  end

  def redis
    @redis ||= Redis.new url: ENV["REDIS_URL"]
  end

  def issues_filter_milestone(repo, name)
    cache_key = milestone_key(repo,name)
    cache_expire = 24.hour

    cache = Rails.cache.read(cache_key)
    if cache.present?
      milestone = cache
    else
      client.list_milestones(repo).each do |m|
        key = milestone_key(repo, m.title)
        Rails.cache.write(key, m, expires_in: cache_expire)
        milestone = m if m.title == name
      end
      Rails.logger.info("use GitHub API: #{client.rate_limit.remaining}")
    end

    if milestone.nil?
      raise "not found milestone: #{milestone.title}"
    end

    Rails.cache.fetch(issues_key(repo,name), expires_in: 3.minutes) do
      Rails.logger.info("use GitHub API: #{client.rate_limit.remaining}")
      client.list_issues(repo, milestone: milestone.number)
    end
  end

  def milestone_key(repo,name)
    "#{repo}/milestone/#{name}"
  end

  def issues_key(repo,name)
    "#{repo}/milestone/issues/#{name}"
  end
end
