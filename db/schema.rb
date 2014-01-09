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

ActiveRecord::Schema.define(version: 20140109093647) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "completed_exercises", force: true do |t|
    t.string   "name"
    t.string   "kind"
    t.float    "time"
    t.string   "timeset",              array: true
    t.integer  "position"
    t.integer  "completed_segment_id"
    t.float    "weight"
    t.string   "weight_unit"
    t.integer  "reps"
    t.text     "descript"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "completed_exercises", ["completed_segment_id"], name: "index_completed_exercises_on_completed_segment_id", using: :btree

  create_table "completed_segments", force: true do |t|
    t.string   "name"
    t.integer  "time"
    t.integer  "position"
    t.integer  "completed_workout_id"
    t.integer  "sets",                 default: 0
    t.integer  "rest_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "completed_segments", ["completed_workout_id"], name: "index_completed_segments_on_completed_workout_id", using: :btree

  create_table "completed_workouts", force: true do |t|
    t.string   "name"
    t.text     "descript"
    t.float    "time"
    t.date     "date"
    t.integer  "rating",     default: 0
    t.integer  "user_id"
    t.float    "goal_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "completed_workouts", ["user_id"], name: "index_completed_workouts_on_user_id", using: :btree

  create_table "exercises", force: true do |t|
    t.string   "name",        default: "New Exercise"
    t.text     "descript"
    t.string   "kind",        default: "Weight Lifting"
    t.integer  "reps",        default: 5
    t.float    "time",        default: 1.0
    t.integer  "position"
    t.float    "weight",      default: 5.0
    t.string   "weight_unit", default: "kg"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercises", ["segment_id"], name: "index_exercises_on_segment_id", using: :btree

  create_table "segments", force: true do |t|
    t.string   "name"
    t.integer  "rest_time",  default: 60
    t.integer  "workout_id"
    t.integer  "position"
    t.integer  "sets",       default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "segments", ["workout_id"], name: "index_segments_on_workout_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.integer  "level"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.hstore   "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workouts", force: true do |t|
    t.string   "name",       default: "New Workout"
    t.text     "descript"
    t.integer  "goal_time",  default: 30
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["user_id"], name: "index_workouts_on_user_id", using: :btree

end
