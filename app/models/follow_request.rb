class FollowRequest < ApplicationRecord
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :recipient, class_name: "User", foreign_key: "recipient_id"

  # TODO: 'rejected', 'blocked' statuses would be fun...
  enum :status, { pending: 0, accepted: 1 }

  validates :recipient_id,
    uniqueness: { scope: :sender_id, message: "Already requested" },
    comparison: { other_than: :sender_id, message: "Cannot follow self" }
end
