class PersonLeagueJoin < ActiveRecord::Base
  belongs_to :person
  belongs_to :league
end
