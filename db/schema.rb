# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_20_191125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pump_families", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "min_gpm"
    t.float "max_gpm"
    t.string "pump_sub_material"
    t.string "pump_family"
  end

  create_table "pumps", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "volt"
    t.integer "phase"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "pump_assembly"
    t.float "graph_points", default: [], array: true
    t.float "hp_pump"
    t.float "stages_pump"
    t.float "weight_pump"
    t.string "discharge_pump"
    t.string "suction_pump"
    t.string "pump_motor_type"
    t.float "pump_amp"
    t.integer "pump_family_id"
    t.float "graph_points_table", default: [], array: true
    t.float "perform_points_table", default: [], array: true
    t.string "pump_type"
    t.integer "volt2"
    t.float "pump_amp2"
  end

  create_table "user_pumps", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pump_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pump_id"], name: "index_user_pumps_on_pump_id"
    t.index ["user_id"], name: "index_user_pumps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "user_pumps", "pumps"
  add_foreign_key "user_pumps", "users"
end
