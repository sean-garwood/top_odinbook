require "test_helper"

class FollowRequestTest < ActiveSupport::TestCase
  test "shoud be two follow request fixtures" do
    assert_equal 2, FollowRequest.count, "There should be two fixtures"
  end
  test "should not save follow_request without follower_id" do
    follow_request = FollowRequest.new
    assert_not follow_request.save, "Saved the follow_request without a follower_id"
  end

  test "should not save follow_request without leader_id" do
    follow_request = FollowRequest.new
    assert_not follow_request.save, "Saved the follow_request without a leader_id"
  end

  test "should have default status of pending" do
    follow_request = FollowRequest.new
    assert_equal "pending", follow_request.status, "Default status should be pending"
  end

  test "should be invalid with nil status" do
    follow_request = FollowRequest.new(status: nil)
    assert_not follow_request.valid?, "Follow request should be invalid with nil status"
  end
end
