class UsersController < ApplicationController
  def index
    @users = User.where.not(id: current_user.id).includes(:profile)
    @followed_users = current_user.followed_users.unscope(:includes)
    @not_followed_users = @users - @followed_users

    case params[:filter]
    when "followed"
      @users = @followed_users
    when "not followed"
      @users = @not_followed_users
    else
      @users = @users
    end
  end
end
