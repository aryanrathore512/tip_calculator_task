class CreateCalculations < ActiveRecord::Migration[7.1]
  def change
    create_table :calculations do |t|
      t.decimal :bill_amount, precision: 10, scale: 2, null: false
      t.decimal :tip_percentage, precision: 5, scale: 2, default: 1.00, null: false
      t.integer :number_of_people, default: 1, null: false
      t.decimal :tip_amount, precision: 10, scale: 2, null: false
      t.decimal :total_bill, precision: 10, scale: 2, null: false
      t.decimal :per_person_amount, precision: 10, scale: 2, null: false

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
