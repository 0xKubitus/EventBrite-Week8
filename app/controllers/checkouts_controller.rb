class CheckoutsController < ApplicationController
before_action :authenticate_user!, only:  [:new, :create]
  def new
    @event_to_pay = Event.find(params[:event_id])
    @amount = @event_to_pay.price
    # @event = Event.find(params[:id])
    # @amount = @event.price
  end

  def create

    puts "#"*100
    puts "params.inspect : #{params.inspect}"
    puts "#"*100

    # @user = current_user
    @event = Event.find(params[:event_id])
    

    # Before the rescue, at the beginning of the method
    @stripe_amount = @event.price*100
    begin
      customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @stripe_amount,
      description: "Achat d'un produit",
      currency: 'eur',
      })
    puts "#"*100
    puts "PAIEMENT ok."
    puts "Stripe::Customer : #{customer.id}."
    puts "Stripe::Customer : #{customer.class}."
    puts "#"*100
      
      Attendance.create(strip_customer_id: customer.id ,event: @event, attendee: current_user) 
      flash.notice = "Ta participation est enregsitrée. (faire une mail ?)"
      redirect_to event_path(@event.id)    

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to event_path(@event.id)
    puts "#"*100
    puts "RESCUE ok."
    puts "#"*100
    end

    puts "#"*100
    puts "APRES TOUT."
    puts "#"*100
    # After the rescue, if the payment succeeded
  end

  # # Utilisation d'une méthode/route #show pour obtenir une URL dynamique pour la page d'affichage du paiement.
  # # De cette façon, on peut récupérer l'id de l'event via params. Ce qui n'aurait pas été le cas avec la méthode #new.
  # def show 
  #   @event_to_pay = Event.find(params[:id])
  #   @amount = @event_to_pay.price
  # end

end
