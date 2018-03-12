class Person < ActiveRecord::Base
  has_many :checkins
  has_many :user_person_joins
  has_many :users, through: :user_person_joins
  has_many :person_league_joins
  has_many :leagues, through: :person_league_joins

  def up_by(event=nil)
    return attributes['up_by'] unless event
    checkins = checkins_for(event)
    first_checkin = checkins.first
    last_checkin = checkins.last
    last_checkin == first_checkin ? nil : last_checkin.weight - first_checkin.weight
  end

  def percentage_change(event)
    weight_change = up_by(event)
    return unless weight_change
    beginning_weight = checkins_for(event).first.try(:weight)
    @percentage_change ||= beginning_weight ?  weight_change.to_f / beginning_weight * 100 : nil
  end

  def checkin_diffs
    grouped = checkins.includes(:event).order('events.created_at').group_by(&:event)
    event_diffs = {}
    grouped.each_pair do |event, event_checkins|
      diffs = event_checkins.sort_by(&:created_at).map(&:delta).compact
      event_diffs[event.try(:name)] = diffs.map { |d| '%.2f' % d }
    end
    event_diffs
  end

  def checkins_for(event)
    event.checkins.where(person: self).order(:created_at)
  end

  def league_for(event)
    leagues.find_by(event: event)
  end
end
