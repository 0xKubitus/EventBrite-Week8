module Admin

  class AdminController < ApplicationController
    before_action :check_if_admin

    def index

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