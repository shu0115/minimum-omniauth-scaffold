  before_filter :authorize              # ログイン認証
  before_filter :reset_session_expires  # セッション有効期限延長

  private

  # ログイン認証
  def authorize
    # セッション／トップコントローラ以外で
    if params[:controller] != "sessions" and params[:controller] != "top"
      unless user_signed_in?
        # リクエストURL保管
        session[:request_url] = request.url

        # ルートヘリダイレクト
        redirect_to :root and return
      end
    end
  end

  # セッション期限延長
  def reset_session_expires
    request.session_options[:expire_after] = 2.weeks
  end

  # ログインユーザ
  def current_user
    @current_user ||= User.where( id: session[:user_id] ).first
  end
  helper_method :current_user

  # ユーザ登録チェック
  def user_signed_in?
    User.where( id: session[:user_id] ).exists?
  end
  helper_method :user_signed_in?
