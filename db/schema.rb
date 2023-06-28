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

ActiveRecord::Schema[7.0].define(version: 2023_06_27_235001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.string "longitude"
    t.string "latitude"
    t.boolean "primary"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admins", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "drivers", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "score", default: 5
    t.string "license"
    t.date "license_expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_drivers_on_user_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "score"
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_passengers_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "passenger_id", null: false
    t.bigint "driver_id", null: false
    t.bigint "vehicle_id", null: false
    t.json "start_location"
    t.json "end_location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.float "distance"
    t.decimal "fare"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_trips_on_driver_id"
    t.index ["passenger_id"], name: "index_trips_on_passenger_id"
    t.index ["vehicle_id"], name: "index_trips_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti"
    t.string "username"
    t.integer "role"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "identification_number"
    t.string "userable_type"
    t.bigint "userable_id"
    t.string "gender"
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["userable_type", "userable_id"], name: "index_users_on_userable"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.bigint "driver_id", null: false
    t.string "vehicle_type"
    t.string "model"
    t.string "plate"
    t.integer "year"
    t.string "color"
    t.string "registration"
    t.date "registration_expiration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_vehicles_on_driver_id"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "admins", "users"
  add_foreign_key "drivers", "users"
  add_foreign_key "passengers", "users"
  add_foreign_key "trips", "drivers"
  add_foreign_key "trips", "passengers"
  add_foreign_key "trips", "vehicles"
  add_foreign_key "vehicles", "drivers"
end
