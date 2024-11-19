class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!, :set_current_user_email_profile

  private
    def set_current_user
      @user = current_user
    end

    def set_user_email
      @email = @user.email unless @user.nil?
    end

    def set_user_profile
      @profile = @user.profile unless @user.nil?
    end

    def set_current_user_email_profile
      set_current_user
      set_user_email
      set_user_profile
    end
end
