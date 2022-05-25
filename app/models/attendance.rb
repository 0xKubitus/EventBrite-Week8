class Attendance < ApplicationRecord
  after_create :new_attendee_send

  belongs_to :attendee, class_name: "User"
  belongs_to :event

  def new_attendee_send
    UserMailer.new_attendee_email(self.event.admin, self).deliver_now
  end
end
