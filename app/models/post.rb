class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates_presence_of :body, :title, :author_id

  private
    def self.by_followed_users(user)
      followed_user_ids = user.followed_user_ids
      followed_user_ids << user.id
      where(author_id: followed_user_ids)
    end
end
