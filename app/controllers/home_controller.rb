class HomeController < ApplicationController
  def index
    repo_name = 'great-h/great-h.github.io'
    @issues = Issue.filter_milestone(repo_name, milestone_name)
    Rails.logger.info(Github.rate_limit.to_s)
  end

  private

  def milestone_name
    Date.today.beginning_of_week(:wednesday).strftime('%Y%m%d')
  end
end
