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

ActiveRecord::Schema.define(version: 2019_04_17_115102) do

  create_table "chore_performance_logs", force: :cascade do |t|
    t.bigint "chore_id", null: false
    t.text "notes"
    t.datetime "performed_at", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["category_id"], name: "index_chores_on_category_id"
    t.index [nil], name: "index_chores_on_preform_next"
  end

  create_table "users", force: :cascade do |t|
    t.integer "chores_total", default: 0, null: false
    t.integer "chores_week", default: 0, null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name"
  end

end
