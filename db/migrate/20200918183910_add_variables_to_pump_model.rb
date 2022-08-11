class AddVariablesToPumpModel < ActiveRecord::Migration[6.0]
  def change
    add_column :pumps, :hp_pump, :float
    add_column :pumps, :stages_pump, :float
    add_column :pumps, :weight_pump, :float
    add_column :pumps, :discharge_pump, :string
  end
end
