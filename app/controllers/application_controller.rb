class ApplicationController < ActionController::Base
  
  def is_watcher_admin?(watcher)
    if watcher && (watcher.id == Event.find(params[:id]).admin.id)
      true 
    else
      false
    end
  end

  def is_watcher_attendee?(watcher)
    if watcher && Event.find(params[:id]).attendee_ids.include?(watcher.id)
      true 
    else
      false
    end
  end

end
