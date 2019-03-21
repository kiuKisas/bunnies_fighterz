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

ActiveRecord::Schema.define(version: 2019_03_20_161245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "bunnies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bunny_fight_stats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.boolean "victory"
    t.integer "life"
    t.integer "total_attack"
    t.integer "succeed_attack"
    t.integer "damage"
    t.uuid "bunny_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "fight_id"
    t.integer "life_total"
    t.uuid "weapon_id"
    t.index ["bunny_id"], name: "index_bunny_fight_stats_on_bunny_id"
    t.index ["fight_id"], name: "index_bunny_fight_stats_on_fight_id"
    t.index ["weapon_id"], name: "index_bunny_fight_stats_on_weapon_id"
  end

  create_table "bunny_stats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "life"
    t.integer "attack"
    t.integer "defense"
    t.integer "stamina"
    t.integer "luck"
    t.uuid "bunny_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bunny_id"], name: "index_bunny_stats_on_bunny_id"
  end

  create_table "fights", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weapon_stats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "life"
    t.integer "attack"
    t.integer "defense"
    t.integer "stamina"
    t.integer "luck"
    t.uuid "weapon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["weapon_id"], name: "index_weapon_stats_on_weapon_id"
  end

  create_table "weapons", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bunny_fight_stats", "bunnies"
  add_foreign_key "bunny_fight_stats", "fights"
  add_foreign_key "bunny_fight_stats", "weapons"
  add_foreign_key "bunny_stats", "bunnies"
  add_foreign_key "weapon_stats", "weapons"
end
