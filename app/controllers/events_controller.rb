class EventsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]
before_action :authorize_edit_access, only: [:edit, :update, :destroy]
before_action :validation_status, only: [:show]

  def index
    @all_events = Event.all.where(validated: true)

    # Un évènement aléatoire à afficher sur la page d'accueil
    @random_event = Event.find(rand(Event.first.id..Event.last.id)) 
  end

  def show
    @event_to_show = Event.find(params[:id])
    @watcher_is_admin = is_watcher_admin?(current_user) # appel d'une méthode définie dans application_controller.rb
    @watcher_is_attendee = is_watcher_attendee?(current_user)
    puts "#"*100
    if current_user
      puts "current_user existe : #{current_user}"
    end
    if !current_user
      puts "current_user existe ? : #{current_user}" 
    end
    # puts "current _user.id : #{current_user.id}"
    puts "#"*100
  end

  def new
    @event_to_create = Event.new
  end

  def create
    event_to_create = Event.new(start_date: params[:start_date], duration: params[:duration], title: params[:title], description: params[:description], price: params[:price], location: params[:location], admin: current_user, validated: nil)

    if event_to_create.save
      flash.notice = "Évènement crée. En cours de validation."
      redirect_to root_path
   else
      flash.alert = event_to_create.errors.full_messages
      redirect_to new_event_path
   end
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
      redirect_to event_path(event_to_update.id)
    else
      # puts "#"*100
      # puts "DANS LE ELSE"
      # puts "#"*100
      flash.alert = event_to_update.errors.full_messages
      redirect_to edit_event_path(event_to_update.id)
   end

    # puts "#"*100
    # puts "APRES LE IF"
    # puts "#"*100
  end

  def destroy
    event_to_destroy = Event.find(params[:id])
    admin_id = event_to_destroy.admin.id
    event_to_destroy.destroy
    redirect_to user_path(admin_id)
  end

  private

  def authorize_edit_access
    unless current_user == Event.find(params[:id]).admin
      flash.alert = "Accès non autorisé."
      redirect_to event_path(Event.find(params[:id]))
    end
  end

  def validation_status
    event = Event.find(params[:id])
    unless event.validated == true
      flash.alert = "Impossible : validation NIL ou FALSE."
      redirect_to root_path
    end
  end

end
