class SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    session[:user_id] = User.find_and_update_or_create_for_omniauth(auth).id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
