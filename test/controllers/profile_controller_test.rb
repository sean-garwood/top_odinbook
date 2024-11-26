require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  setup do
    create_and_sign_in_user
    @profile = @user.profile
  end
  test "should get show" do
    get profile_path(@profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_path
    assert_response :success
  end

  test "should update profile" do
    patch profile_path(@profile), params: { profile: { bio: "Updated Bio" } }
    assert_redirected_to profile_path
    @profile.reload
    assert_equal "Updated Bio", @profile.bio
  end
end
