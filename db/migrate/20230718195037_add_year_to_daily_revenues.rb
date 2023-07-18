class AddYearToDailyRevenues < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_revenues, :year, :integer
  end
end
