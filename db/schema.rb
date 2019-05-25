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

ActiveRecord::Schema.define(version: 2019_05_25_222754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "family_id"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["family_id"], name: "index_accounts_on_family_id"
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.integer "chore_count", default: 0, null: false
    t.string "color", limit: 6
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "family_id"
    t.index ["family_id"], name: "index_categories_on_family_id"
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "chore_performance_logs", force: :cascade do |t|
    t.bigint "chore_id", null: false
    t.text "notes"
    t.datetime "performed_at", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "family_id"
    t.index ["family_id"], name: "index_chore_performance_logs_on_family_id"
  end

  create_table "chores", force: :cascade do |t|
    t.bigint "category_id"
    t.string "description", null: false
    t.integer "frequency", null: false
    t.integer "frequency_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_performed"
    t.datetime "perform_next"
    t.bigint "family_id"
    t.index ["category_id"], name: "index_chores_on_category_id"
    t.index ["family_id"], name: "index_chores_on_family_id"
    t.index ["perform_next"], name: "index_chores_on_preform_next"
  end

  create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
  end

  create_table "families", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "chores_total", default: 0, null: false
    t.integer "chores_week", default: 0, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "family_id"
    t.bigint "account_id"
    t.index ["family_id"], name: "index_users_on_family_id"
    t.index ["name"], name: "index_users_on_name"
  end

end
