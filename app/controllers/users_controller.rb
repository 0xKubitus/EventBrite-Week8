class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :is_profile_owner?, only: [:show, :edit, :update]

  def show
    @user_to_show = User.find(params[:id])
  end

  def edit
    @user_to_edit = User.find(params[:id])
  end

  def update
    user_to_update = User.find(params[:id])

    if user_to_update.update(first_name: params[:first_name], last_name: params[:last_name], description:params[:description])
      flash.notice = "Informations mises à jour."
      redirect_to user_path(user_to_update.id)
   else
      flash.alert = user_to_update.errors.full_messages
      redirect_to new_event_path
   end

  end

private

  def is_profile_owner?
    owner = User.find(params[:id])
    unless owner == current_user
      flash.alert = "Accès non autorisé."
      redirect_to root_path
    end
  end

end