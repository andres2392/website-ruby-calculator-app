class RemoveIntegerAssembly < ActiveRecord::Migration[6.0]
  def change
    remove_column :pumps, :pump_assembly, :integer
  end
end
