require "test_helper"

class LikeTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    @post = posts(:one)
    sign_in @user
  end
  test "same user can't like same post twice" do
    @user = users(:one)
    @post = posts(:one)
    @like = Like.create(user: @user, post: @post)
    assert_not @like.save, "Saved the like twice"
  end
end
