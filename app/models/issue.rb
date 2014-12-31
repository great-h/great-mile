class Issue
  def self.filter_milestone(repo, name)
    milestone = Milestone.find(repo, name)
    return [] if milestone.nil?

    Rails.cache.fetch(issues_key(repo, name), expires_in: 3.minutes) do
      Github.client.list_issues(repo, milestone: milestone.number, state: 'all')
    end
  end

  def self.issues_key(repo, name)
    "#{repo}/issues/milestone/#{name}"
  end
end
