class AddLocationToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :city, :string
    add_column :contacts, :country, :string
    add_column :contacts, :postal_code, :string
  end
end
