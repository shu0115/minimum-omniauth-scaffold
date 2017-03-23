class SessionsController < ApplicationController
  skip_before_action :authenticate

  def callback
    auth = request.env["omniauth.auth"]
    authentication = Authentication.find_by(provider: auth["provider"], uid: auth["uid"]) || Authentication.create_with_omniauth(auth)
    authentication.auth_update(auth)

    user = User.find_by(id: authentication.user_id) || User.create_with_auth(authentication, request)

    session[:user_id] = user.id

    unless session[:request_url].blank?
      redirect_to session[:request_url]
      session[:request_url] = nil
      return
    end

    redirect_to :root and return
  end

  def destroy
    session[:user_id] = nil

    redirect_to :root and return
  end

  def failure
    flash[:alert] = 'Auth Failure'

    redirect_to :root and return
  end
end
