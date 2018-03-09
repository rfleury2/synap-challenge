class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.references :event, index: true, null: false
      t.date       :date
      t.string     :name

      t.timestamps
    end
  end
end
