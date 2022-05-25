module Admin

  class UsersController < ApplicationController
    before_action :check_if_admin

    def index
      @all_users = User.all
      # @user_to_add = User.new
    end

    def new
      @user_to_add = User.new
    end

    def create
      puts "#"*100
      puts "params.inspect : #{params.inspect}"
      puts "#"*100
      
      if params[:is_app_admin] == "1"
        access_level = true
      elsif params[:is_app_admin] == "0"  
        access_level = false
      end

      user_to_add = User.new(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], description:params[:description], password: params[:password], description: params[:description], is_app_admin: access_level)


      
      if user_to_add.save
        flash.notice = "User crée."
        redirect_to admin_users_path
      else
        flash.alert = user_to_add.errors.full_messages
        redirect_to new_admin_user_path
      end

    end

    def show

    end

    def edit
      @user_to_edit = User.find(params[:id])
    end

    def update
      # puts "#"*100
      # puts "On est dans le USER#UPDATE"
      # puts "params.inspect : #{params.inspect}"
      # puts "#"*100
      if params[:is_app_admin] == "1"
        access_level = true
      elsif params[:is_app_admin] == "0"  
        access_level = false
      end

      user_to_update = User.find(params[:id])

      if user_to_update.update(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], description:params[:description], password: params[:password], description: params[:description], is_app_admin: access_level)
        flash.notice = "Informations mises à jour."
        redirect_to admin_users_path
      else
        flash.alert = user_to_update.errors.full_messages
        redirect_to edit_admin_user_path(user_to_update.id)
      end
    end

    def destroy
      @user_to_destroy = User.find(params[:id])
      # puts "#"*100
      # puts "@user_to_destroy est #{@user_to_destroy.id}"
      # puts "#"*100
      flash.notice = "Fonction désactivée pour l'instant."
      # @user_to_destroy.destroy
      redirect_to admin_users_path
    end

    private
    
    def check_if_admin

      unless current_user && current_user.is_app_admin
        flash.alert = "accès non aurotisé"
        redirect_to root_path
      end
      
    end
  end

end