class CreateOperations < ActiveRecord::Migration[6.1]
  def change
    create_table :operations do |t|
      t.datetime :created
      t.references :product, null: false, foreign_key: true
      t.decimal :quantity, precision: 10, scale: 2, null: false
      t.decimal :sale_price, precision: 10, scale: 2, null: false
      t.integer :discount_percent, null: false
      t.references :operation_type, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
