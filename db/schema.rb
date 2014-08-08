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

ActiveRecord::Schema.define(version: 20140807170435) do

  create_table "departments", force: true do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faculties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ivles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locklinks", force: true do |t|
    t.integer  "module_id"
    t.integer  "locked_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nusmods", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.string   "workload"
    t.integer  "department_id", limit: 255
    t.string   "academicyear"
    t.string   "moduletype"
    t.integer  "ivle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preclulinks", force: true do |t|
    t.integer  "module_id"
    t.integer  "exlude_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
