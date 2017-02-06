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

ActiveRecord::Schema.define(version: 20170206003555) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bed_templates", force: :cascade do |t|
    t.string   "name"
    t.integer  "design_width"
    t.integer  "design_height"
    t.jsonb    "config"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "early_sign_ups", force: :cascade do |t|
    t.text     "email"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "newsletter", default: false
    t.string   "zipcode"
  end

  create_table "flower_attributes", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_flower_attributes_on_name", using: :btree
  end

  create_table "flower_attributes_plants", id: false, force: :cascade do |t|
    t.integer "flower_attribute_id", null: false
    t.integer "plant_id",            null: false
    t.index ["flower_attribute_id", "plant_id"], name: "join_fa_plant", using: :btree
    t.index ["plant_id", "flower_attribute_id"], name: "join_plant_fa", using: :btree
  end

  create_table "flower_colors", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_flower_colors_on_name", using: :btree
  end

  create_table "foliage_colors", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_foliage_colors_on_name", using: :btree
  end

  create_table "garden_styles", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_garden_styles_on_name", using: :btree
  end

  create_table "garden_styles_plants", id: false, force: :cascade do |t|
    t.integer "garden_style_id", null: false
    t.integer "plant_id",        null: false
    t.index ["garden_style_id", "plant_id"], name: "index_garden_styles_plants_on_garden_style_id_and_plant_id", using: :btree
    t.index ["plant_id", "garden_style_id"], name: "index_garden_styles_plants_on_plant_id_and_garden_style_id", using: :btree
  end

  create_table "growth_rates", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_growth_rates_on_name", using: :btree
  end

  create_table "key_features", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_key_features_on_name", using: :btree
  end

  create_table "key_features_plants", id: false, force: :cascade do |t|
    t.integer "key_feature_id", null: false
    t.integer "plant_id",       null: false
    t.index ["key_feature_id", "plant_id"], name: "index_key_features_plants_on_key_feature_id_and_plant_id", using: :btree
    t.index ["plant_id", "key_feature_id"], name: "index_key_features_plants_on_plant_id_and_key_feature_id", using: :btree
  end

  create_table "leave_types", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_leave_types_on_name", using: :btree
  end

  create_table "light_needs", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_light_needs_on_name", using: :btree
  end

  create_table "plant_types", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_plant_types_on_name", using: :btree
  end

  create_table "plants", force: :cascade do |t|
    t.text     "common_name"
    t.text     "scientific_name"
    t.text     "source_url"
    t.text     "image_url"
    t.text     "description"
    t.float    "avg_height"
    t.float    "avg_width"
    t.text     "care_info"
    t.boolean  "store_available"
    t.text     "store_url"
    t.float    "store_cost"
    t.integer  "leave_type_id"
    t.integer  "growth_rate_id"
    t.integer  "flower_color_id"
    t.integer  "foliage_color_id"
    t.integer  "light_need_id"
    t.integer  "watering_need_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.text     "watering_needs_raw"
    t.text     "average_size_raw"
    t.integer  "plant_type_id"
    t.index ["avg_height"], name: "index_plants_on_avg_height", using: :btree
    t.index ["avg_width"], name: "index_plants_on_avg_width", using: :btree
    t.index ["common_name"], name: "index_plants_on_common_name", using: :btree
    t.index ["flower_color_id"], name: "index_plants_on_flower_color_id", using: :btree
    t.index ["foliage_color_id"], name: "index_plants_on_foliage_color_id", using: :btree
    t.index ["growth_rate_id"], name: "index_plants_on_growth_rate_id", using: :btree
    t.index ["leave_type_id"], name: "index_plants_on_leave_type_id", using: :btree
    t.index ["light_need_id"], name: "index_plants_on_light_need_id", using: :btree
    t.index ["plant_type_id"], name: "index_plants_on_plant_type_id", using: :btree
    t.index ["scientific_name"], name: "index_plants_on_scientific_name", using: :btree
    t.index ["store_available"], name: "index_plants_on_store_available", using: :btree
    t.index ["watering_need_id"], name: "index_plants_on_watering_need_id", using: :btree
  end

  create_table "plants_special_features", id: false, force: :cascade do |t|
    t.integer "plant_id",           null: false
    t.integer "special_feature_id", null: false
    t.index ["plant_id", "special_feature_id"], name: "join_plant_sf", using: :btree
    t.index ["special_feature_id", "plant_id"], name: "join_sf_plant", using: :btree
  end

  create_table "plants_usages", id: false, force: :cascade do |t|
    t.integer "plant_id", null: false
    t.integer "usage_id", null: false
    t.index ["plant_id", "usage_id"], name: "index_plants_usages_on_plant_id_and_usage_id", using: :btree
    t.index ["usage_id", "plant_id"], name: "index_plants_usages_on_usage_id_and_plant_id", using: :btree
  end

  create_table "plants_zones", id: false, force: :cascade do |t|
    t.integer "plant_id", null: false
    t.integer "zone_id",  null: false
    t.index ["plant_id", "zone_id"], name: "index_plants_zones_on_plant_id_and_zone_id", using: :btree
    t.index ["zone_id", "plant_id"], name: "index_plants_zones_on_zone_id_and_plant_id", using: :btree
  end

  create_table "special_features", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_special_features_on_name", using: :btree
  end

  create_table "usages", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_usages_on_name", using: :btree
  end

  create_table "watering_needs", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_watering_needs_on_name", using: :btree
  end

  create_table "zones", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_zones_on_name", using: :btree
  end

end
