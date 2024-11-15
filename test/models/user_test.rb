require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new
    assert_not user.save, "Saved the user without an email"
  end

  test "should be two fixtures" do
    assert_equal 2, User.count, "There should be two fixtures"
  end
end
