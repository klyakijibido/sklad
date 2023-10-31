class CreateDiscountCards < ActiveRecord::Migration[6.1]
  def change
    create_table :discount_cards do |t|
      t.string :name

      t.timestamps
    end
  end
end
