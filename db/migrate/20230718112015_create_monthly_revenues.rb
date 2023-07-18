class CreateMonthlyRevenues < ActiveRecord::Migration[5.2]
  def change
    create_table :monthly_revenues do |t|
      t.date :month
      t.decimal :revenue
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end
