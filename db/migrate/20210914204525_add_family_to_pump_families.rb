class AddFamilyToPumpFamilies < ActiveRecord::Migration[6.0]
  def change
    add_column :pump_families, :pump_family, :string
  end
end
