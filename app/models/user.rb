class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :build_default_profile

  delegate :name, to: :profile, allow_nil: true
  has_many :comments, dependent: :destroy, inverse_of: :author
  has_many :received_follow_requests,
    class_name: "FollowRequest", foreign_key: :recipient_id,
    dependent: :destroy
  has_many :sent_follow_requests,
    class_name: "FollowRequest", foreign_key: :sender_id,
    dependent: :destroy

  has_many :accepted_follow_requests, -> { accepted },
    class_name: "FollowRequest", foreign_key: :recipient_id
  has_many :follow_requests, -> { pending },
    class_name: "FollowRequest",
    foreign_key: :sender_id
  has_many :followed_users, through: :accepted_follow_requests, source: :recipient
  has_many :followers, through: :received_follow_requests, source: :user
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :posts, inverse_of: :author, dependent: :destroy
  has_one :profile, dependent: :destroy, inverse_of: :user, touch: true
  has_one :name, through: :profile

  scope :not_followed_users, ->(user) { includes(:name).where.not(id: user.followed_users) }

  validates_presence_of :email, unique: true

  def feed
    Post.order(:created_at).includes(:author).where(author: followed_users).or(Post.where(author: self))
  end

  def follow(user)
    follow_requests.create(recipient: user)
  end

  # HACK: N+1 and tons of dumb checks.
  # This is a very inefficient way to check if a user is following another user.
  def following?(user)
    followed_users.include?(user)
  end


  def following_or_sent_pending_request_to?(user) # HACK
    following?(user) || sent_pending_request_to?(user)
  end

  def has_received_follow_requests? # HACK
    FollowRequest.received(self).exists?
  end

  def sent_pending_request_to?(user) # HACK
    sent_follow_requests.pending.where(recipient: user).exists?
  end

  private
    def build_default_profile
      @profile = Profile.new(user: self,
        name: Faker::TvShows::Simpsons.character,
        bio: Faker::TvShows::Simpsons.quote)
      logger = (@profile.save) ? "Profile created successfully." : "Failed to create profile."
      Rails.logger.info { logger }
    end
end
