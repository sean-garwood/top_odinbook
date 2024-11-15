require "test_helper"

class FollowRequestsControllerTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers
  setup do
    @users = users
    @users.each do |user|
      @user = user
      sign_in @user
    end
  end

  test "should get new" do
    get new_follow_request_path
    assert_response :success
  end

  test "should create follow request" do
    post follow_requests_path, params: { follow_request: { leader_id: users(:one).id, follower_id: users(:two).id } }
    assert_response :redirect
  end
  test "should show follow request" do
    follow_request = follow_requests(:one) # Assuming you have a fixture named :one
    get follow_request_path(follow_request)
    assert_response :success
  end

  test "should destroy follow request" do
    follow_request = follow_requests(:one) # Assuming you have a fixture named :one
    delete follow_request_path(follow_request)
    assert_response :success
  end
end
