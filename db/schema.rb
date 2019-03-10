# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180110150251) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "botnets", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_botnets_on_name", unique: true
  end

  create_table "departures", force: :cascade do |t|
    t.date "date_start"
    t.text "description"
    t.bigint "incident_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incident_id"], name: "index_departures_on_incident_id"
    t.index ["user_id"], name: "index_departures_on_user_id"
  end

  create_table "documents", force: :cascade do |t|
    t.date "date_signature"
    t.string "number"
    t.string "destination"
    t.text "description"
    t.bigint "incident_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incident_id"], name: "index_documents_on_incident_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.text "description"
    t.date "date_event"
    t.bigint "incident_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incident_id"], name: "index_events_on_incident_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "incidents", force: :cascade do |t|
    t.date "date_receive"
    t.date "date_incident"
    t.date "date_close"
    t.string "state"
    t.text "description"
    t.string "source"
    t.text "current_state"
    t.bigint "organisation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "identificator"
    t.index ["organisation_id"], name: "index_incidents_on_organisation_id"
    t.index ["user_id"], name: "index_incidents_on_user_id"
  end

  create_table "infected_machines", force: :cascade do |t|
    t.string "mac"
    t.string "name"
    t.string "ip"
    t.bigint "incident_id"
    t.bigint "botnet_id"
    t.bigint "organisation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hdd_id"
    t.text "description"
    t.index ["botnet_id"], name: "index_infected_machines_on_botnet_id"
    t.index ["incident_id"], name: "index_infected_machines_on_incident_id"
    t.index ["organisation_id"], name: "index_infected_machines_on_organisation_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "contact_tech"
    t.string "contact_security"
    t.string "ip"
    t.string "region"
    t.string "handler"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "remote_control_center_id"
    t.bigint "incident_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incident_id"], name: "index_relationships_on_incident_id"
    t.index ["remote_control_center_id", "incident_id"], name: "index_relationships_on_remote_control_center_id_and_incident_id", unique: true
    t.index ["remote_control_center_id"], name: "index_relationships_on_remote_control_center_id"
  end

  create_table "remote_control_centers", force: :cascade do |t|
    t.string "name"
    t.string "ip"
    t.string "domain"
    t.string "country"
    t.text "description"
    t.bigint "botnet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["botnet_id"], name: "index_remote_control_centers_on_botnet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "surname"
    t.string "second_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "departures", "incidents"
  add_foreign_key "departures", "users"
  add_foreign_key "documents", "incidents"
  add_foreign_key "documents", "users"
  add_foreign_key "events", "incidents"
  add_foreign_key "events", "users"
  add_foreign_key "incidents", "organisations"
  add_foreign_key "incidents", "users"
  add_foreign_key "infected_machines", "botnets"
  add_foreign_key "infected_machines", "incidents"
  add_foreign_key "infected_machines", "organisations"
  add_foreign_key "relationships", "incidents"
  add_foreign_key "relationships", "remote_control_centers"
  add_foreign_key "remote_control_centers", "botnets"
end
