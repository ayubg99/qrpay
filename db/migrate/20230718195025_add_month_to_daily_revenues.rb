class AddMonthToDailyRevenues < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_revenues, :month, :integer
  end
end
