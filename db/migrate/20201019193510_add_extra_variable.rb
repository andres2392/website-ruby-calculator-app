class AddExtraVariable < ActiveRecord::Migration[6.0]
  def change
    add_column :pumps, :pump_sub_material, :string
  end
end
