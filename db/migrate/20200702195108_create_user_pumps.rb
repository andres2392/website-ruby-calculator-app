class CreateUserPumps < ActiveRecord::Migration[6.0]
  def change
    create_table :user_pumps do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pump, null: false, foreign_key: true

      t.timestamps
    end
  end
end
