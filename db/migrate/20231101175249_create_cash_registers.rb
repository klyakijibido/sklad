class CreateCashRegisters < ActiveRecord::Migration[6.1]
  def change
    create_table :cash_registers do |t|
      t.string :name

      t.timestamps
    end
  end
end
