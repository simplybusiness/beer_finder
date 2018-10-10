class AddLatAndLongToOutlet < ActiveRecord::Migration[5.1]
  def change
    add_column :outlets, :lat, :float
    add_column :outlets, :long, :float
  end
end
