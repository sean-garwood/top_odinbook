require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome_email" do
    @new_user = create_and_sign_in_user
    email = UserMailer.with(user: @new_user).welcome_email
    assert_emails 1 do
      email.deliver_now
    end
  end
end
