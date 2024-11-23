class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user! # , :set_current_user

  # TODO: investigate session, cookies, etc. for current_user/devise
  #   what is exposed to what?
  #   was getting NoMethodErrors out the wazoo for calling current_user from
  #   FollowRequestsController, but not now.
  #
  # def get_current_user
  #   Rails.logger.debug "setting current_user to #{current_user}"
  #   @user = current_user
  # end
end
