class AddIdentificatorToIncident < ActiveRecord::Migration[5.1]
  def change
    add_column :incidents, :identificator, :integer
  end
end
