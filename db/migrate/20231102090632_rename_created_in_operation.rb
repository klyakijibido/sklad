class RenameCreatedInOperation < ActiveRecord::Migration[6.1]
  def change
    rename_column :operations, :created, :date_created
  end
end
