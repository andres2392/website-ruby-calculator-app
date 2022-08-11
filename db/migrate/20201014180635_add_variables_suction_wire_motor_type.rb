class AddVariablesSuctionWireMotorType < ActiveRecord::Migration[6.0]
  def change
    add_column :pumps, :suction_pump, :string
    add_column :pumps, :pump_motor_type, :string
    add_column :pumps, :pump_motor_wire, :integer
  end
end
