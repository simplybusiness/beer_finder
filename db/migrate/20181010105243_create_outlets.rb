class CreateOutlets < ActiveRecord::Migration[5.1]
  def change
    create_table :outlets do |t|
      t.string :xero_contact_id
      t.string :name
      t.string :address
      t.string :postcode
      t.string :outlet_type

      t.timestamps
    end
  end
end
