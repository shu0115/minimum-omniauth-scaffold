  before_action :authenticate

  private

  def authenticate
    unless signed_in?
      session[:request_url] = request.url

      redirect_to :root and return
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def signed_in?
    User.where(id: session[:user_id]).exists?
  end
  helper_method :signed_in?
