require "test_helper"
class UserTest < ActiveSupport::TestCase
include Devise::Test::IntegrationHelpers

  test "should not save user without email" do
    user = User.new
    assert_not user.save, "Saved the user without an email"
  end

  test "should not save user without password" do
    user = User.new
    assert_not user.save, "Saved the user without a password"
  end
end
