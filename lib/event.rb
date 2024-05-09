require 'time'

class Event
  attr_accessor :start_date, :duration, :title, :attendees

  def initialize(start_time, duration, title, attendees=[])
    @start_date = Time.parse(start_time)
    @duration = duration
    @title = title
    @attendees = attendees
  end
def postpone_24h
  @start_date += 86400  # Add 24 hours in seconds
end
def end_date
  @start_date + (@duration * 60)  # Convert duration to seconds
end
def is_past?
  Time.now > @start_date
end
def is_future?
  Time.now < @start_date
end
def is_soon?
  (Time.now + (30 * 60)) > @start_date && is_future?
end
def to_s
  "Titre : #{@title}\nDate de début : #{@start_date.strftime("%H:%M:%S %d/%m/%Y")}\nDurée : #{@duration} minutes\nInvités : #{attendees.join(", ")}"
end
def self.find_by_email(email)
  @@all_users.find { |user| user.email == email }
end
