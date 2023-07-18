class AddYearToMonthlyRevenues < ActiveRecord::Migration[5.2]
  def change
    add_column :monthly_revenues, :year, :integer
  end
end
