class CreateInfectedMachines < ActiveRecord::Migration[5.1]
  def change
    create_table :infected_machines do |t|
      t.string :mac
      t.string :name
      t.string :ip

      t.references :incident, foreign_key: true, index: true
      t.references :botnet, foreign_key: true, index: true
      t.references :organisation, foreign_key: true, index: true

      t.timestamps
    end
  end
end
