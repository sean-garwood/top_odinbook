require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @author = users(:one)
  end
  test "should not save post without title" do
    assert_not Post.new(body: "This is the body of the post", author_id: 1).save, "saved without title"
  end

  test "should not save post without body" do
    assert_not Post.new(title: "This is the title of the post", author_id: 1).save, "saved without body"
  end

  test "should not save post without author_id" do
    assert_not Post.new(title: "This is the title of the post", body: "This is the body of the post").save, "saved without author_id"
  end
end
