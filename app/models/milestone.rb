class Milestone
  def self.raw_open(repo)
    Github.client.list_milestones(repo,
                                  state: 'open',
                                  direction: 'desc')
  end

  def self.raw_closed(repo)
    Github.client.list_milestones(repo,
                                  state: 'closed',
                                  direction: 'desc')
  end

  def self.all(repo)
    cache_key = milestones_key(repo)
    cache_expire = 3.minute
    cache = Rails.cache.read(cache_key)
    if cache.present?
      milestones = cache
    else
      milestones = raw_open(repo) + raw_closed(repo)
      Rails.cache.write(cache_key, milestones, expires_in: cache_expire)
    end
    milestones
  end

  def self.find(repo, name)
    cache_key = milestone_key(repo, name)
    cache_expire = 24.hour

    cache = Rails.cache.read(cache_key)
    if cache.present?
      milestone = cache
    else
      all(repo).each do |m|
        key = milestone_key(repo, m)
        Rails.cache.write(key, m, expires_in: cache_expire)
        milestone = m if m.title == name
      end
    end
    milestone
  end

  def self.milestones_key(repo)
    "#{repo}/milestones"
  end

  def self.milestone_key(repo, name)
    "#{repo}/milestone/#{name}"
  end
end
