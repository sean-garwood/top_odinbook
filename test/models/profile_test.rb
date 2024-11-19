require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  test "should not save profile without user_id" do
    assert_not Profile.new(bio: "This is the bio of the profile").save, "saved without user_id"
  end

  test "should not save profile without bio" do
    assert_not Profile.new(user_id: 1).save, "saved without bio"
  end

  test "new user should have a profile" do
    create_and_sign_in_user
    assert_not_nil @user.profile, "new user does not have a profile"
  end
end
