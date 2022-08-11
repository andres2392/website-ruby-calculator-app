class ChangePointsFromIntegerToFloat < ActiveRecord::Migration[6.0]
  def change
    remove_column :pumps, :graph_points
    add_column :pumps, :graph_points, :float, array: true, default: []
  end
end
