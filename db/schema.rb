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

ActiveRecord::Schema.define(version: 20130725182759) do

  create_table "initiatives", force: true do |t|
    t.datetime "election_date"
    t.string   "prop_letter"
    t.string   "title"
    t.text     "description"
    t.boolean  "pass_fail"
    t.integer  "yes_count"
    t.integer  "no_count"
    t.string   "percent_required"
    t.string   "measure_type"
    t.string   "initiator"
    t.string   "scan_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
