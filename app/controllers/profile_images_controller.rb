class ProfileImagesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @user.profile_image.attach(params[:profile_image])
    redirect_to user_path(@user)
  end
end
