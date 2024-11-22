module UsersHelper
  AVATAR_SRC_TEMPLATE = "https://www.gravatar.com/avatar/%s?s=%d&d=identicon".freeze

  def avatar_src_url(user = @user, email = @email, size = 80)
    email_hash = Digest::SHA256.hexdigest(email)
    AVATAR_SRC_TEMPLATE % [ email_hash, size ]
  end

  def avatar(user = @user)
    image_tag(avatar_src_url(user), class: "avatar", alt: "profile pic")
  end
end
