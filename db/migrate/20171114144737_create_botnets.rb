class CreateBotnets < ActiveRecord::Migration[5.1]
  def change
    create_table :botnets do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    add_index :botnets, :name, unique: true
  end
end
