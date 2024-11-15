class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy, inverse_of: :author
  has_many :follow_requests, dependent: :destroy
  has_many :followers, through: :follow_requests
  has_many :leaders, through: :follow_requests
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :posts, inverse_of: :author, dependent: :destroy
  validates_presence_of :email, unique: true
end
