class UsersController < ApplicationController
  def index
    @users = User.all.includes(:profile)
  end
end
