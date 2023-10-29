class CreateProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :full_name

      t.timestamps
    end
  end
end
