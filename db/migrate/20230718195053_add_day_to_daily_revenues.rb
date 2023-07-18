class AddDayToDailyRevenues < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_revenues, :day, :integer
  end
end
