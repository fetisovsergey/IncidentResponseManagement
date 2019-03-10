class CreateOrganisations < ActiveRecord::Migration[5.1]
  def change
    create_table :organisations do |t|
      t.string :name
      t.string :address
      t.string :contact_tech
      t.string :contact_security
      t.string :ip
      t.string :region
      t.string :handler
      t.text :description
      
      t.timestamps
    end
  end
end
