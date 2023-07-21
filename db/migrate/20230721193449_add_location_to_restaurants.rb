class AddLocationToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :city, :string
    add_column :restaurants, :country, :string
    add_column :restaurants, :postal_code, :string
  end
end