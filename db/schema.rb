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

ActiveRecord::Schema[8.0].define(version: 2025_04_20_135207) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "author_types", ["Person", "Organization"]
  create_enum "target_types", ["Person", "Event"]
  create_enum "types_of_notifications", ["info", "invite", "offer", "warning"]

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "image"
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.bigint "organization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geometry "location", limit: {:srid=>4326, :type=>"st_point"}
    t.boolean "online", default: false, null: false
    t.index ["organization_id"], name: "index_events_on_organization_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "follower_id", null: false
    t.bigint "not_approved_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_friendships_on_author_id"
    t.index ["follower_id"], name: "index_friendships_on_follower_id"
    t.index ["not_approved_id"], name: "index_friendships_on_not_approved_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "person_id"
    t.string "text", null: false
    t.boolean "read", default: false, null: false
    t.enum "author_type", enum_type: "author_types"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "target_type", enum_type: "target_types"
    t.bigint "target_id"
    t.enum "notice_type", default: "info", null: false, enum_type: "types_of_notifications"
    t.index ["author_id", "author_type"], name: "index_notifications_on_author_id_and_author_type"
    t.index ["person_id"], name: "index_notifications_on_person_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "activity_field"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "accredited", default: false, null: false
    t.index ["email"], name: "index_organizations_on_email", unique: true
    t.index ["reset_password_token"], name: "index_organizations_on_reset_password_token", unique: true
  end

  create_table "participants", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visible", limit: 2, default: 0, null: false
    t.boolean "accepted", default: true, null: false
    t.index ["event_id"], name: "index_participants_on_event_id"
    t.index ["person_id"], name: "index_participants_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.date "birthday"
    t.text "description"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_people_on_email", unique: true
    t.index ["reset_password_token"], name: "index_people_on_reset_password_token", unique: true
  end

  create_table "starred_organizations", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_starred_organizations_on_organization_id"
    t.index ["person_id"], name: "index_starred_organizations_on_person_id"
  end

  add_foreign_key "friendships", "people", column: "author_id"
  add_foreign_key "friendships", "people", column: "follower_id"
  add_foreign_key "friendships", "people", column: "not_approved_id"
  add_foreign_key "participants", "events"
  add_foreign_key "participants", "people"
  add_foreign_key "starred_organizations", "organizations"
  add_foreign_key "starred_organizations", "people"
end
