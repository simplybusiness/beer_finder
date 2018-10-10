class CreateStockItems < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_items do |t|
      t.references :outlet, foreign_key: true
      t.string :name
      t.string :style
      t.string :serving_style
      t.date :delivery_date

      t.timestamps
    end
  end
end
