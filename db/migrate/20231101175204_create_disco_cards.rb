class CreateDiscoCards < ActiveRecord::Migration[6.1]
  def change
    create_table :disco_cards do |t|
      t.string :name

      t.timestamps
    end
  end
end
