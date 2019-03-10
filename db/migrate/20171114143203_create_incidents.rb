class CreateIncidents < ActiveRecord::Migration[5.1]
  def change
    create_table :incidents do |t|
      t.date :date_receive
      t.date :date_incident
      t.date :date_close
      t.string :state
      t.text :description
      t.string :source
      t.text :current_state
      t.text :docs

      t.references :organisation, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
