class UsersController < ApplicationController
  def index
    login_required
    @orgnizations = client.organizations
    @repos = client.repos(params[:user])
  end

  private
  def client
    @client ||= Github.client(current_user)
  end
end
