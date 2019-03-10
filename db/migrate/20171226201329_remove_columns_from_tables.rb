class RemoveColumnsFromTables < ActiveRecord::Migration[5.1]
  def change
    # Remove Docs column from Incidents table
    remove_column :incidents, :docs, :string

    # Remove Indexes
    remove_index :remote_control_centers, :name
    remove_index :remote_control_centers, :domain
    remove_index :remote_control_centers, :ip
  end
end
