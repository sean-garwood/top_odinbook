class ProfileController < ApplicationController
  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: "Profile updated"
    else
      flash.now[:alert] = "Profile not updated: #{@profile.errors.full_messages.join(", ")}"
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def profile_params
      params.require(:profile).permit(:bio)
    end
end
