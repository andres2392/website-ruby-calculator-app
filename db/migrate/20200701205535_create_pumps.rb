class CreatePumps < ActiveRecord::Migration[6.0]
  def change
    create_table :pumps do |t|
      t.string :name
      t.string :description
      t.integer :volt
      t.integer :phase
      t.string :pump_type
      t.integer :pump_assembly
      t.string :link

      t.timestamps
    end
  end
end
