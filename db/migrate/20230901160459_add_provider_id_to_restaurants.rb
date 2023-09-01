class AddProviderIdToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_reference :restaurants, :provider, foreign_key: true
  end
end
