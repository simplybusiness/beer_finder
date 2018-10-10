class AddInvoiceIdToStockItems < ActiveRecord::Migration[5.1]
  def change
    add_column :stock_items, :invoice_id, :string
  end
end
