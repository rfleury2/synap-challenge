require 'csv'

def seed_participants
  previous_event = Event.new
  previous_league = League.new
  CSV.foreach("#{Rails.root}/participants.csv", headers: true) do |row|
    person_name = row['Name']
    person = Person.find_or_create_by!(name: person_name)
    
    event_tagline = 'placeholder tagline'
    event_name = row['Event']
    is_new_event = previous_event.name != event_name || previous_event.tagline != event_tagline
    if is_new_event
      event = Event.find_or_create_by!(name: event_name, tagline: event_tagline)
      previous_event = event
    else
      event = previous_event
    end

    league_name = row['League']
    league_date = row['Date'].to_date
    is_new_league = previous_league.date != league_date || previous_league.name != league_name
    if is_new_league 
      league = League.find_or_create_by!(name: league_name, event: event, date: league_date)
      previous_league = league
    end
  end
end

def seed_weighins
  previous_event = Event.new
  previous_person = Person.new
  CSV.foreach("#{Rails.root}/weighins.csv", headers: true) do |row|
    event_tagline = 'placeholder tagline'
    event_name = row['Event']
    is_different_event = previous_event.name != event_name && previous_event.tagline != event_tagline
    event = is_different_event ? Event.find_by(name: event_name) : previous_event

    person_name = row['Name']
    is_different_person = previous_person.name != person_name
    person = is_different_person ? Person.find_by(name: person_name) : previous_person

    first_checkin = Checkin.where(person: person, event: event).first
    weight = row['Weight'].to_d
    time = row['Time'].to_datetime
    checkin = Checkin.find_or_initialize_by(person: person, event: event, weight: weight, created_at: time)
    delta = weight - first_checkin.weight if first_checkin
    checkin.delta = delta
    checkin.save!
  end
end

def seed_all
  seed_participants
  seed_weighins
end

seed_all