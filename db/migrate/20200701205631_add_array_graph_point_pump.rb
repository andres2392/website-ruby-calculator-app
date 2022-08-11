class AddArrayGraphPointPump < ActiveRecord::Migration[6.0]
  def change
    add_column :pumps, :graph_points, :int, array: true, default: []
  end
end
