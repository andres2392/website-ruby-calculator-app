class AddFamilyToPump < ActiveRecord::Migration[6.0]
  def change
    add_column :pumps, :pump_family_id, :integer
    add_column :pumps, :graph_points_table, :float, array:true, default: []
    add_column :pumps, :perform_points_table, :float, array:true, default: []
    add_column :pumps, :pump_type, :string

  end
end
