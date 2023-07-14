class AddPaymentInformationToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :stripe_account_id, :string
    add_column :restaurants, :bank_account_number, :string
    add_column :restaurants, :bank_routing_number, :string
    add_column :restaurants, :bank_account_holder_name, :string
  end
end
