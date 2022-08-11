class AddStringAssembly < ActiveRecord::Migration[6.0]
  def change
    add_column :pumps, :pump_assembly, :string
  end
end
