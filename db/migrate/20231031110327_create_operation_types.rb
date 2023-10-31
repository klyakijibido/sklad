class CreateOperationTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :operation_types do |t|
      t.string :name, null: false, index: { unique: true }
      t.integer :multiplier_cash, null: false
      t.integer :multiplier_quantity, null: false

      t.timestamps
    end
  end
end
