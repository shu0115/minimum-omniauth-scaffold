class User < ActiveRecord::Base
#  attr_accessible :provider, :uid, :name, :nickname, :image, :email, :location, :token, :secret

  # auth情報更新
  def auth_update( auth )
    if auth["provider"] == "facebook"
      image_path = "https://graph.facebook.com/#{auth['info']['nickname'].presence || auth["uid"]}/picture?width=200&height=200"
    else
      image_path = auth["info"]["image"]
    end

    if self.name != auth["info"]["name"] or self.nickname != auth["info"]["nickname"] or self.image != image_path or self.email != auth["info"]["email"] or self.location != auth["info"]["location"]
      self.name     = auth["info"]["name"]
      self.nickname = auth["info"]["nickname"]
      self.image    = image_path
      self.email    = auth["info"]["email"]
      self.location = auth["info"]["location"]
      self.save!
    end
  end

  private

  # auth情報登録
  def self.create_with_omniauth( auth )
    user = User.new
    user.provider = auth["provider"]
    user.uid      = auth["uid"]

    if auth["info"].present?
      user.name     = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]
      user.image    = auth["info"]["image"]
      user.email    = auth["info"]["email"]
      user.location = auth["info"]["location"]
    end

    if auth["credentials"].present?
      user.token  = auth['credentials']['token']
      user.secret = auth['credentials']['secret']
    end

    user.save!

    return user
  end
end
