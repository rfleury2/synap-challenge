class CreatePersonLeagueJoin < ActiveRecord::Migration
  def change
    create_table :person_league_joins do |t|
      t.references :person, index: true
      t.references :league, index: true

      t.timestamps
    end
  end
end
