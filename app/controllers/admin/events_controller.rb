module Admin

  class EventsController < ApplicationController
    before_action :check_if_admin

    def index
      @all_events = Event.all
      # @user_to_add = User.new
    end

    def new
      @event_to_add = Event.new
    end

    def create
      puts "#"*100
      puts "params.inspect : #{params.inspect}"
      puts "#"*100
      
      event_to_create = Event.new(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin: current_user, validated: nil)

        if event_to_create.save
          flash.notice = "Évènement crée. En cours de validation."
          redirect_to admin_event_submissions_path
      else
          flash.alert = event_to_create.errors.full_messages
          redirect_to new_event_path
      end

    end

    def show

    end

    def edit
      @event_to_edit = Event.find(params[:id])
    end

    def update
      # event_to_update = Event.update(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin: current_user)
      event_to_update = Event.find(params[:id])

      # puts "#"*100
      # puts "AVANT LE IF"
      # puts "#"*100

      if event_to_update.update(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin: current_user)
      # puts "#"*100
      # puts "DANS LE IF"
      # puts "#"*100
        flash.notice = "Évènement mis à jour"
        redirect_to admin_events_path
      else
        # puts "#"*100
        # puts "DANS LE ELSE"
        # puts "#"*100
        flash.alert = event_to_update.errors.full_messages
        redirect_to edit_admin_event_path(event_to_update.id)
   end

    # puts "#"*100
    # puts "APRES LE IF"
    # puts "#"*100
  end

    def destroy
      event_to_destroy = Event.find(params[:id])
      admin_id = event_to_destroy.admin.id
      flash.notice = "fonction désactivée pour l'instant"
      # event_to_destroy.destroy
      redirect_to admin_events_path
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