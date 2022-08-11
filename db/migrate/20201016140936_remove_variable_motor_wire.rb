class RemoveVariableMotorWire < ActiveRecord::Migration[6.0]
  def change
    remove_column :pumps, :pump_motor_wire, :integer
  end
end
