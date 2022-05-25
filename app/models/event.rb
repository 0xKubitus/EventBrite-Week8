class Event < ApplicationRecord
  has_many :attendances
  has_many :attendees, foreign_key:'user_id', through: :attendances, class_name: "User"
  has_one_attached :avatar

  belongs_to :admin, class_name: "User"
  has_one_attached :event_image

  validate :check_date_is_not_past, :duration_multiple_5

  validates :start_date,
    presence: true
  
  validates :duration,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  validates :title,
    presence: true,
    length: { minimum: 5, maximum: 140 }

  validates :description,
    presence: true,
    length: { minimum: 20, maximum: 1000 }

  validates :price,
  presence: true,
  numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1000 }

  validates :location, :avatar,
  presence: true

  def check_date_is_not_past
    if start_date <= Time.now
      errors.add(:start_date, "La start_date doit être dans le futur.")
    end
  end

  def duration_multiple_5
    if duration % 5 !=0
      errors.add(:duration, "La durée doit être un multiple de 5.")
    end
  end

  def calc_end_date
    self.start_date + self.duration*60
  end

end
