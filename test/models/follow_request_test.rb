require "test_helper"

class FollowRequestTest < ActiveSupport::TestCase
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

  test "should be accessible from follower" do
    follower = users(:one)
    leader = users(:three)
    rq = follower.follow_requests.build(leader: leader, status: "accepted")
    assert_includes follower.follow_requests, rq, "Follow request should be accessible from follower"
  end
end
