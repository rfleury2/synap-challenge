class Checkin < ActiveRecord::Base
  belongs_to :person
  belongs_to :event
  belongs_to :user

  def self.for_event(event)
    where(event: event)
  end
end
