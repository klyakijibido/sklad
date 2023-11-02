class CreateBadProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :bad_products do |t|
      t.string :description
      t.integer :repit

      t.timestamps
    end
  end
end
