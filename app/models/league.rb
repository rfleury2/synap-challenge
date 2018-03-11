class League < ActiveRecord::Base
  belongs_to :event
  has_many :person_league_joins
  has_many :people, through: :person_league_joins
end