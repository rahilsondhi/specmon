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

ActiveRecord::Schema.define(version: 20151030004716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "examples", force: :cascade do |t|
    t.string   "file"
    t.string   "name"
    t.float    "run_time"
    t.string   "vcs_revision"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "examples", ["vcs_revision", "run_time"], name: "index_examples_on_vcs_revision_and_run_time", using: :btree
  add_index "examples", ["vcs_revision"], name: "index_examples_on_vcs_revision", using: :btree

end
