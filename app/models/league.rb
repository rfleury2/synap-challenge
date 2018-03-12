class League < ActiveRecord::Base
  belongs_to :event
  has_many :person_league_joins
  has_many :people, through: :person_league_joins

  def participants_by_rank
    people.sort_by { |person| person.up_by(event) || -1000 }.reverse
  end
end