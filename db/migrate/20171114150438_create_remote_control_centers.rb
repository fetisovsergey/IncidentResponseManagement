class CreateRemoteControlCenters < ActiveRecord::Migration[5.1]
  def change
    create_table :remote_control_centers do |t|
      t.string :name
      t.string :ip
      t.string :domain
      t.string :country
      t.text :description

      t.references :botnet, foreign_key: true, index: true

      t.timestamps
    end

    add_index :remote_control_centers, :name, unique: true
    add_index :remote_control_centers, :ip, unique: true
    add_index :remote_control_centers, :domain, unique: true
  end
end
