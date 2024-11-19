module ApplicationHelper
  AVATAR_SRC_TEMPLATE = "https://www.gravatar.com/avatar/%s?s=%d&d=identicon".freeze

  def avatar_src_url(email, size = 80)
    email_hash = Digest::SHA256.hexdigest(email)
    AVATAR_SRC_TEMPLATE % [ email_hash, size ]
  end
end
