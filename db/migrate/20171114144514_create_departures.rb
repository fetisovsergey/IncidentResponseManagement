class CreateDepartures < ActiveRecord::Migration[5.1]
  def change
    create_table :departures do |t|
      t.date :date_start
      t.text :description

      t.references :incident, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
