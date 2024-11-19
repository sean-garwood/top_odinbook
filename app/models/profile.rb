class Profile < ApplicationRecord
  belongs_to :user
  devise primary_key: :user_id

  before_save { self.bio.nil? ? self.bio = "Welcome to my profile! I have not updated the default bio." : self.bio }
end
