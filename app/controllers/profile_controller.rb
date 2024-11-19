class ProfileController < ApplicationController
  def show
    @profile = current_user.profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "Profile updated"
    else
      render :edit
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:bio)
    end
end
