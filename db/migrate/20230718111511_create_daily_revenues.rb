class CreateDailyRevenues < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_revenues do |t|
      t.date :date
      t.decimal :revenue
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end