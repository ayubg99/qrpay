class AddNameToProviders < ActiveRecord::Migration[5.2]
  def change
    add_column :providers, :name, :string
  end
end
