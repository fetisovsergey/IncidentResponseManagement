class AddColumnsToInfectedMachine < ActiveRecord::Migration[5.1]
  def change
  	add_column :infected_machines, :hdd_id, :string
  	add_column :infected_machines, :description, :text
  end
end
