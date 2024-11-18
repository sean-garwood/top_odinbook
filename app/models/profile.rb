class Profile < ApplicationRecord
  belongs_to :user
  devise primary_key: :user_id
end
