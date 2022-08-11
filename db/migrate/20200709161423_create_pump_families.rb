class CreatePumpFamilies < ActiveRecord::Migration[6.0]
  def change
    create_table :pump_families do |t|
      t.string :name
      t.string :tg
      t.string :type
      t.integer :min_gpm
      t.integer :max_gpm
      t.integer :count

      t.timestamps
    end
  end
end
