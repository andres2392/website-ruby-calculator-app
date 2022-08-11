class AddVariablesAmp < ActiveRecord::Migration[6.0]
  def change
    add_column :pumps, :pump_amp, :float
  end
end
