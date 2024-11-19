class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :build_default_profile

  has_many :comments, dependent: :destroy, inverse_of: :author
  has_many :follow_requests, foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :follow_requests
  has_many :leaders, through: :follow_requests
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :posts, inverse_of: :author, dependent: :destroy
  has_one :profile, dependent: :destroy, inverse_of: :user, touch: true
  validates_presence_of :email, unique: true

  private
    def build_default_profile
      @profile = Profile.new(user: self)
      @profile.bio = "Welcome to my profile! I have not updated the default bio."
      logger = (@profile.save) ? "Profile created successfully." : "Failed to create profile."
      Rails.logger.info { logger }
    end
end
