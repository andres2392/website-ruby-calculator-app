class RemoveExtraVariable < ActiveRecord::Migration[6.0]
  def change
    remove_column :pumps, :pump_sub_material, :string
    add_column :pump_families, :pump_sub_material, :string

  end
end
