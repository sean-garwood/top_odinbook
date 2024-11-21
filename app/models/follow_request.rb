class FollowRequest < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

  enum :status, { pending: 0, accepted: 1, rejected: 2, blocked: 3 }

  scope :accepted, -> { where(status: :accepted) }
  scope :received, ->(user) { where(status: :pending, recipient_id: user.id) }

  validate :not_following_self
  validates :recipient_id, uniqueness: { scope: :user_id, message: "already requested" }

  private
    def not_following_self
      errors.add(:recipient, "can't follow self") if user == recipient
    end
end
