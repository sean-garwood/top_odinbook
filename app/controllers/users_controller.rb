class UsersController < ApplicationController
  def index
    @users = User.all.includes(:profile).where.not(id: current_user.id)
  end
end
