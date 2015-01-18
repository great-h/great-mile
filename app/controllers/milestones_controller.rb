class MilestonesController < ApplicationController
  def index
    @repo = "#{params[:user]}/#{params[:repository]}"
    @repo == "great-h/great-h.github.io"
    @milestone = params[:milestone]
    @issues = Issue.filter_milestone(@repo, @milestone)
    render 'home/index'
  end
end
