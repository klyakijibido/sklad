class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :art
      t.string :razd
      t.string :sor
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :price_buy, precision: 10, scale: 2, null: false
      t.integer :code, null: false
      t.references :provider, null: false, foreign_key: true
      t.references :country, null: false, foreign_key: true
      t.references :plant, null: false, foreign_key: true
      t.string :ean13

      t.timestamps
    end
  end
end
