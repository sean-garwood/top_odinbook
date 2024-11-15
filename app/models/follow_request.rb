class FollowRequest < ApplicationRecord
  scope :accepted, -> { where(status: "accepted") }
  scope :pending, -> { where(status: "pending") }
  scope :rejected, -> { where(status: "rejected") }

  belongs_to :leader, class_name: "User", foreign_key: "leader_id"
  belongs_to :follower, class_name: "User", foreign_key: "follower_id"

  validates_presence_of :leader_id, :follower_id

  validates :status, presence: true,
            inclusion: { in: %w[pending accepted rejected] }
end
