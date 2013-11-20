class Authentication < ActiveRecord::Base
  belongs_to :user

  # バリデーション
  validates :provider, presence: true
  validates :uid, presence: true

  # auth情報更新
  def auth_update(auth)
    if auth["provider"] == "facebook"
      image_path = "https://graph.facebook.com/#{auth['info']['nickname'].presence || auth["uid"]}/picture?width=200&height=200"
    elsif auth["provider"] == "twitter"
      image_path = auth["info"]["image"].to_s.gsub('_normal', '') rescue nil
    end

    gender   = auth["extra"]["raw_info"]["gender"] rescue nil
    location = (auth["info"]["location"].presence || auth["extra"]["raw_info"]["location"]) rescue nil

    # if self.name != auth["info"]["name"] or self.nickname != auth["info"]["nickname"] or self.image != image_path or self.email != auth["info"]["email"] or self.image != image_path
      self.name     = auth["info"]["name"]     if auth["info"]["name"].present?
      self.nickname = auth["info"]["nickname"] if auth["info"]["nickname"].present?
      self.image    = image_path               if image_path.present?
      self.email    = auth["info"]["email"]    if auth["info"]["email"].present?
      self.gender   = gender                   if gender.present?
      self.location = location                 if location.present?
      self.save!
    # end
  rescue => e
    puts "[ ---------- e ---------- ]" ; e.tapp ;
    return nil
  end

  private

  # auth情報登録／ユーザ作成
  def self.create_with_omniauth(auth)
    # auth情報登録
    authentication = Authentication.new
    authentication.provider = auth["provider"]
    authentication.uid      = auth["uid"]

    if auth["info"].present?
      authentication.name     = auth["info"]["name"]
      authentication.nickname = auth["info"]["nickname"]
      authentication.image    = auth["info"]["image"]
      authentication.email    = auth["info"]["email"]
      authentication.location = auth["info"]["location"]
    end

    if auth["credentials"].present?
      authentication.token  = auth['credentials']['token']
      authentication.secret = auth['credentials']['secret']
    end

    if auth["extra"].present? and auth["extra"]["raw_info"].present?
      authentication.gender   = auth["extra"]["raw_info"]["gender"]
      authentication.location = auth["extra"]["raw_info"]["location"] if authentication.location.blank?
    end

    # ユーザ作成
    user = User.new
    user.name = authentication.nickname.presence || authentication.name
    user.image = authentication.image if authentication.image.present?
    user.email = authentication.email if authentication.email.present?
    user.last_login_provider = authentication.provider if authentication.provider.present?
    user.last_login_at = Time.now

    # データ保存
    user.save!
    authentication.user_id = user.id
    authentication.save!

    return authentication
  end
end
