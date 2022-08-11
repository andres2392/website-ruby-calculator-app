class DeleteRowPumpFamAndAdd < ActiveRecord::Migration[6.0]
  def change
    remove_column :pump_families, :min_gpm
    remove_column :pump_families, :max_gpm
    add_column :pump_families, :min_gpm, :float
    add_column :pump_families, :max_gpm, :float
  end
end
