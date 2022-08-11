class AddVolt2AndAmp2 < ActiveRecord::Migration[6.1]
  def change
    add_column :pumps, :volt2, :integer
    add_column :pumps, :pump_amp2, :float
  end
end
