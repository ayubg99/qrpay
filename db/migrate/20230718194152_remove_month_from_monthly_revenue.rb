class RemoveMonthFromMonthlyRevenue < ActiveRecord::Migration[5.2]
  def change
    remove_column :monthly_revenues, :month, :date
  end
end
