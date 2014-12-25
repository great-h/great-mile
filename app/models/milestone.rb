class Milestone
  def self.find(repo, name)
    cache_key = milestone_key(repo, name)
    cache_expire = 24.hour

    cache = Rails.cache.read(cache_key)
    if cache.present?
      milestone = cache
    else
      Github.client.list_milestones(repo).each do |m|
        key = milestone_key(repo, m.title)
        Rails.cache.write(key, m, expires_in: cache_expire)
        milestone = m if m.title == name
      end
    end
    milestone
  end

  def self.milestone_key(repo, name)
    "#{repo}/milestone/#{name}"
  end
end
