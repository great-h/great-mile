class HomeController < ApplicationController
  def index
    @repo = 'great-h/great-h.github.io'
    @milestone = milestone_name
    @issues = Issue.filter_milestone(@repo, @milestone)
    Rails.logger.info(Github.rate_limit.to_s)
  end

  private

  def milestone_name
    Date.today.beginning_of_week(:wednesday).strftime('%Y%m%d')
  end
end
