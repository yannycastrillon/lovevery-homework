# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_19_141459) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "children", force: :cascade do |t|
    t.string "full_name", null: false, comment: "The child's full name"
    t.date "birthdate", null: false, comment: "This child's birthdate or expecting date"
    t.string "parent_name", null: false, comment: "The full name of the child's parent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["full_name", "birthdate", "parent_name"], name: "index_children_on_full_name_and_birthdate_and_parent_name", unique: true
  end

  create_table "gifters", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_gifters_on_email", unique: true
  end

  create_table "gifts", force: :cascade do |t|
    t.bigint "product_id", null: false, comment: "What product is this order for?"
    t.bigint "child_id", null: false, comment: "Which child is this for?"
    t.bigint "gifter_id", null: false, comment: "Which gifter is sending the gift?"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_gifts_on_child_id"
    t.index ["gifter_id"], name: "index_gifts_on_gifter_id"
    t.index ["product_id"], name: "index_gifts_on_product_id"
  end

  create_table "order_gifts", force: :cascade do |t|
    t.bigint "order_id", null: false, comment: "What order to give away gift?"
    t.bigint "gift_id", null: false, comment: "Which gift are you ordering?"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["gift_id"], name: "index_order_gifts_on_gift_id"
    t.index ["order_id"], name: "index_order_gifts_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "user_facing_id", null: false, comment: "A user-facing ID we can give the user to track their order in our system"
    t.bigint "product_id", null: false, comment: "What product is this order for?"
    t.bigint "child_id", null: false, comment: "Which child is this for?"
    t.string "shipping_name", null: false, comment: "Name of who we are shipping to"
    t.string "address", null: false, comment: "Street Address for shipping"
    t.string "zipcode", null: false, comment: "Zip Code for shipping"
    t.boolean "paid", null: false, comment: "True if this order has been paid via a successful charge"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_orders_on_child_id"
    t.index ["product_id"], name: "index_orders_on_product_id"
  end

  create_table "products", comment: "Product catalog", force: :cascade do |t|
    t.string "name", null: false, comment: "The name of the product"
    t.text "description", null: false, comment: "Longer description of the product"
    t.integer "price_cents", null: false, comment: "Retail price, in cents, of the product"
    t.integer "age_low_weeks", null: false, comment: "Lowest appropriate age for this product, in weeks"
    t.integer "age_high_weeks", null: false, comment: "Highest appropriate age for this product, in weeks"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "gifts", "children"
  add_foreign_key "gifts", "gifters"
  add_foreign_key "gifts", "products"
  add_foreign_key "order_gifts", "gifts"
  add_foreign_key "order_gifts", "orders"
  add_foreign_key "orders", "children"
  add_foreign_key "orders", "products"
end
