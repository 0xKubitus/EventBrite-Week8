class EventImagesController < ApplicationController

  def create
    @event = Event.find(params[:event_id])
    @event.event_image.attach(params[:event_image])
    redirect_to event_path(@event)
  end
  
end
