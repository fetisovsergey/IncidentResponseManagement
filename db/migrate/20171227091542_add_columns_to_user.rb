class AddColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :surname, :string
  	add_column :users, :second_name, :string
  end
end
