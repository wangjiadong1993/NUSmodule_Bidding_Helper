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

ActiveRecord::Schema.define(version: 20140829075526) do

  create_table "biddings", force: true do |t|
    t.integer  "academicyear"
    t.integer  "nusmod_id"
    t.integer  "lowestsuccess"
    t.integer  "lowestbid"
    t.integer  "highestbid"
    t.string   "accounttype"
    t.string   "round"
    t.integer  "bidder"
    t.integer  "quota"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "modhists", force: true do |t|
    t.datetime "examtime"
    t.integer  "semester"
    t.integer  "nusmod_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "modtimes", force: true do |t|
    t.integer  "nusmod_id"
    t.integer  "classnum"
    t.string   "lessontype"
    t.integer  "weekcode"
    t.string   "weektext"
    t.integer  "daycode"
    t.string   "daytext"
    t.integer  "endtime"
    t.integer  "starttime"
    t.string   "venue"
    t.string   "academicyear"
    t.integer  "semester"
    t.boolean  "deleflag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nusmods", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "description"
    t.string   "workload"
    t.integer  "department_id"
    t.string   "academicyear"
    t.string   "moduletype"
    t.integer  "ivle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "modulecredit"
  end

  create_table "preclulinks", force: true do |t|
    t.integer  "module_id"
    t.integer  "exclude_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usermodules", force: true do |t|
    t.integer  "nusmod_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.integer  "startyear"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "gpoint"
    t.integer  "general_point", default: 0
    t.integer  "program_point", default: 0
  end

end
