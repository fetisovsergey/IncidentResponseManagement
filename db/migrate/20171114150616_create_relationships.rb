class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.references :remote_control_center, foreign_key: true, index: true
      t.references :incident, foreign_key: true, index: true
      t.timestamps
    end

    add_index :relationships, [:remote_control_center_id, :incident_id], unique: true
  end
end
