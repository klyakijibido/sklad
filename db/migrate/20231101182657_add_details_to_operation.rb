class AddDetailsToOperation < ActiveRecord::Migration[6.1]
  def change
    add_reference :operations, :disco_card, null: false, foreign_key: true
    add_reference :operations, :cash_register_id, null: false, foreign_key: true
    add_column :operations, :rest_before, :decimal, precision: 10, scale: 2, null: false
  end
end
