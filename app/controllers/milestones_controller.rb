class MilestonesController < ApplicationController
  before_action :param_set

  def index
    @milestones = Milestone.all(repo_name)
  end

  def show
    @milestone = params[:id]
    @issues = Issue.filter_milestone(repo_name, @milestone)
    render 'home/index'
  end

  private
  def param_set
    @user = params[:user]
    @repo = params[:repository]
    raise '他のリポジトリは未対応' unless repo_name == "great-h/great-h.github.io"
  end

  def repo_name
    "#{@user}/#{@repo}"
  end
end
