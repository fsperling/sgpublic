# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151119130234) do

  create_table "buslines", force: true do |t|
    t.integer  "uid"
    t.integer  "busnumber"
    t.integer  "direction"
    t.string   "type_of_bus"
    t.integer  "start_code"
    t.integer  "end_code"
    t.string   "freq_am_peak"
    t.string   "freq_am_off"
    t.string   "freq_pm_peak"
    t.string   "freq_pm_off"
    t.integer  "loop_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buslines", ["busnumber"], name: "index_buslines_on_busnumber"

  create_table "busstop_details", force: true do |t|
    t.integer  "uid"
    t.integer  "busstop_id"
    t.string   "road"
    t.string   "desc"
    t.float    "lat"
    t.float    "long"
    t.integer  "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "busstops", force: true do |t|
    t.integer  "uid"
    t.string   "busnumber"
    t.integer  "direction"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "stop_number"
    t.integer  "busstation_id"
  end

  add_index "busstops", ["busnumber"], name: "index_busstops_on_busnumber"
  add_index "busstops", ["busstation_id"], name: "index_busstops_on_busstation_id"

end
