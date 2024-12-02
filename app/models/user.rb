class User < ApplicationRecord
  include SimpsonsHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create -> { create_profile(name: simpsons_name, bio: simpsons_quote) }
  # send a welcome email after a user is created
  after_create -> { UserMailer.with(user: self).welcome_email.deliver_later }

  delegate :name, to: :profile, allow_nil: true
  has_many :comments, dependent: :destroy, inverse_of: :author
  has_many :likes
  has_many :liked_posts,
    through: :likes,
    source: :post
  has_many :posts,
    inverse_of: :author,
    dependent: :destroy
  has_one :profile,
    dependent: :destroy,
    inverse_of: :user
  has_many :received_follow_requests,
    dependent: :destroy,
    inverse_of: :recipient,
    class_name: "FollowRequest"
  has_many :sent_follow_requests,
    dependent: :destroy,
    inverse_of: :sender,
    class_name: "FollowRequest"

  validates_presence_of :email, unique: true

  def feed
    Post.order(created_at: :desc).includes(author: :profile)
      .where(author: followed_users).or(Post.where(author: self))
  end

  def follow(user)
    follow_requests.create(recipient: user)
  end

  def followed_users
    # return a collection of users that have accepted a sent request
    User.where(
      id: FollowRequest.accepted.where(sender: self)
        .pluck(:recipient_id))
  end

  def following?(user)
    followed_users.include?(user)
  end


  def following_or_sent_pending_request_to?(user)
    following?(user) || sent_pending_request_to?(user)
  end

  def sent_pending_request_to?(user)
    sent_follow_requests.pending.where(recipient: user).exists?
  end
end
