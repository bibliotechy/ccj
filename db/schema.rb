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

ActiveRecord::Schema.define(version: 20171204022317) do

  create_table "artists", force: :cascade do |t|
    t.text "name_en"
    t.text "name_jp"
    t.string "viaf_identifier"
    t.string "local_identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists_components", id: false, force: :cascade do |t|
    t.integer "component_id", null: false
    t.integer "artist_id", null: false
  end

  create_table "components", force: :cascade do |t|
    t.string "local_identifer"
    t.string "identifier"
    t.string "previous_ids"
    t.integer "work_id"
    t.text "description_en"
    t.text "description_jp"
    t.string "contributors_jp"
    t.date "creation_date"
    t.string "color"
    t.string "sound"
    t.datetime "run_time"
    t.string "collection"
    t.string "media_type"
    t.string "media_format"
    t.string "component_type"
    t.string "relation"
    t.string "film_print_type"
    t.integer "fps"
    t.string "brand"
    t.string "file_ame"
    t.string "codec"
    t.string "codec_id"
    t.float "file_size_gb"
    t.string "duration"
    t.string "bit_rate"
    t.string "dimensions"
    t.string "display_aspect_ratio"
    t.string "bit_depth"
    t.string "scan_type"
    t.datetime "encoded_date"
    t.text "provenance"
    t.text "viewing_restrictions"
    t.text "terms_governing_use"
    t.text "housing_annotations"
    t.text "item_annotations"
    t.text "condition_notes"
    t.text "notes"
    t.date "date_of_entry"
    t.string "cataloger"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_id"], name: "index_components_on_work_id"
  end

  create_table "works", force: :cascade do |t|
    t.text "title_en"
    t.text "title_jp"
    t.text "description_en"
    t.text "description_jp"
    t.string "local_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
