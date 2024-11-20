class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :build_default_profile

  has_many :comments, dependent: :destroy, inverse_of: :author
  has_many :follow_requests
  has_many :accepted_follow_requests, -> { accepted }, class_name: "FollowRequest"
  has_many :followed_users, through: :accepted_follow_requests, source: :recipient
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :posts, inverse_of: :author, dependent: :destroy
  has_one :profile, dependent: :destroy, inverse_of: :user, touch: true
  delegate :name, to: :profile, allow_nil: true
  validates_presence_of :email, unique: true

  private
    def build_default_profile
      @profile = Profile.new(user: self,
        name: Faker::TvShows::Simpsons.character,
        bio: Faker::TvShows::Simpsons.quote)
      logger = (@profile.save) ? "Profile created successfully." : "Failed to create profile."
      Rails.logger.info { logger }
    end
end
