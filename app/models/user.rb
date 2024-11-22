class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :build_default_profile

  delegate :name, to: :profile, allow_nil: true
  has_many :comments, dependent: :destroy, inverse_of: :author
  has_many :follow_requests
  has_many :accepted_follow_requests, -> { accepted }, class_name: "FollowRequest"
  has_many :followed_users, through: :accepted_follow_requests, source: :recipient
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :posts, inverse_of: :author, dependent: :destroy
  has_one :profile, dependent: :destroy, inverse_of: :user, touch: true

  validates_presence_of :email, unique: true

  def feed
    Post.where(author: followed_users).or(Post.where(author: self))
  end

  def follow(user)
    follow_requests.create(recipient: user)
  end

  def followers
    User.joins(:accepted_follow_requests).where(follow_requests: { recipient: self })
  end

  def follow_requests_received
    FollowRequest.pending.where(recipient: self)
  end

  def follow_requests_sent
    follow_requests.pending.where(user: self)
  end

  def handle
    name || email
  end

  def unfollow(user)
    follow_requests.find_by(recipient: user)&.destroy
  end

  def followed_by?(user)
    user.following?(self)
  end

  def following?(user)
    followed_users.include?(user)
  end

  def following_or_sent_pending_request_to?(user)
    following?(user) || sent_pending_request_to?(user)
  end

  def has_received_follow_requests?
    FollowRequest.received(self).exists?
  end

  def sent_pending_request_to?(user)
    follow_requests.pending.where(recipient: user).exists?
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
