class UsersController < ApplicationController
  def index
    @users = User.includes(:profile, :followed_users).all
  end
end
