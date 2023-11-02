class DropDiscountCards < ActiveRecord::Migration[6.1]
  def change
    drop_table :discount_cards
  end
end
