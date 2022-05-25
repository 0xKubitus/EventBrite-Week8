module Admin

  class EventSubmissionsController < ApplicationController
    before_action :check_if_admin, only: [:index]
    
    def index
      @events_to_validate = Event.all.where(validated: nil)
      @all_events = Event.all
      puts "#"*100
      puts " @events_to_validate.inspect : #{@events_to_validate.inspect}"
      puts "#"*100
    end

    def new

    end

    def created

    end

    def show
      @event_to_show = Event.find(params[:id])
    end

    def edit

    end

    def update
      event_to_validate = Event.find(params[:id])
      puts "#"*100
      puts "params.inspect : #{params.inspect}"
      puts "#"*100

      if params[:validated] == "1"

        if event_to_validate.update(validated: true)
          puts "#"*100
          puts "ON EST DANS LE PETIT IF"
          puts "#"*100
          flash.notice = "Évènement validé"
          redirect_to admin_event_submissions_path
        else
          flash.alert = "Erreur de l'Update"
          redirect_to admin_event_submission_path(event_to_validate.id)
        end

      elsif params[:validated] == "0"

        if event_to_validate.update(validated: false)
          puts "#"*100
          puts "ON EST DANS LE PETIT IF"
          puts "#"*100
          flash.notice = "Évènement refusé"
          redirect_to admin_event_submissions_path
        else
          flash.alert = "Erreur de l'Update"
          redirect_to admin_event_submission_path(event_to_validate.id)
        end

      end

    end

    def destroy

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