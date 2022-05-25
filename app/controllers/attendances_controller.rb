class AttendancesController < ApplicationController
before_action :authorize_index_access, only: [:index]

  def index
    @all_attendances = Attendance.all
    @event_to_edit = Event.find(params[:event_id])
  end

private

  def authorize_index_access
    unless current_user == Event.find(params[:event_id]).admin
      flash.alert ="Accès non autorisé"
      redirect_to event_path(params[:event_id])
    end
  end

end