require "test_helper"

class CommentTest < ActiveSupport::TestCase
  test "should not save comment without body" do
    comment = Comment.new
    assert_not comment.save, "Saved the comment without a body"
  end
end
