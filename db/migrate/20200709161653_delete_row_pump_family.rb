class DeleteRowPumpFamily < ActiveRecord::Migration[6.0]
  def change
    remove_column :pump_families, :tg
  end
end
