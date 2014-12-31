class HomeController < ApplicationController
  def index
    @repo = 'great-h/great-h.github.io'
    @milestone = milestone_name
    @issues = Issue.filter_milestone(@repo, @milestone)
    if @issues.length == 0
      @milestone = milestone_name(Date.today.prev_week)
      @issues = Issue.filter_milestone(@repo, @milestone)
    end
    Rails.logger.info(Github.rate_limit.to_s)
  end

  private

  def milestone_name(date = Date.today)
    date.beginning_of_week(:wednesday).strftime('%Y%m%d')
  end
end
