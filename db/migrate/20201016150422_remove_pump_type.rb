class RemovePumpType < ActiveRecord::Migration[6.0]
  def change
    remove_column :pumps, :pump_type, :string
  end
end
