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

ActiveRecord::Schema.define(version: 20181010132306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "outlets", force: :cascade do |t|
    t.string "xero_contact_id"
    t.string "name"
    t.string "address"
    t.string "postcode"
    t.string "outlet_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat"
    t.float "long"
  end

  create_table "stock_items", force: :cascade do |t|
    t.bigint "outlet_id"
    t.string "name"
    t.string "style"
    t.string "serving_style"
    t.date "delivery_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoice_id"
    t.index ["outlet_id"], name: "index_stock_items_on_outlet_id"
  end

  add_foreign_key "stock_items", "outlets"
end
