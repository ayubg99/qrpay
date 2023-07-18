class AddDateToDailyRevenues < ActiveRecord::Migration[5.2]
  def change
    add_column :daily_revenues, :date, :date
  end
end
