class AddMonthToMonthlyRevenues < ActiveRecord::Migration[5.2]
  def change
    add_column :monthly_revenues, :month, :integer
  end
end
