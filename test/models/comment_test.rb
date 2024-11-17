require "test_helper"

class CommentTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
    sign_in @user
  end
  test "should not save comment without body" do
    comment = Comment.new
    assert_not comment.save, "Saved the comment without a body"
  end

  test "comment cannot be saved without a user" do
    comment = Comment.new(body: "This is a comment")
    assert_not comment.save, "Saved the comment without a user"
  end
end
