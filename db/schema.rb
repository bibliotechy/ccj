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

ActiveRecord::Schema.define(version: 20171111234334) do

  create_table "artists_tables", force: :cascade do |t|
    t.string "local_id"
    t.string "artist_name_en"
    t.string "artist_name_jp"
    t.string "viaf_id"
  end

  create_table "components", force: :cascade do |t|
    t.string "name"
    t.string "local_id"
    t.string "previous_id"
    t.string "artist_name_en"
    t.string "artist_name_jp"
    t.text "description_en"
    t.text "description_jp"
    t.string "contributors_en"
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
    t.string "file_name"
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
    t.string "provenance"
    t.string "viewing_restrictions"
    t.string "terms_governing_use"
    t.string "housing_annotations"
    t.string "item_annotations"
    t.string "condition_notes"
    t.string "notes"
    t.datetime "date_of_entry"
    t.string "cataloger"
    t.integer "artist_id"
    t.index ["artist_id"], name: "index_components_on_artist_id"
  end

  create_table "works_tables", force: :cascade do |t|
    t.string "local_id"
    t.string "title_en"
    t.string "title_jp"
    t.string "description_en"
    t.string "description_jp"
  end

end
