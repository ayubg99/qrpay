class RemoveDateFromDailyRevenues < ActiveRecord::Migration[5.2]
  def change
    remove_column :daily_revenues, :date, :date
  end
end
