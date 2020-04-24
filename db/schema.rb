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

ActiveRecord::Schema.define(version: 2020_04_16_065051) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "arrangements", force: :cascade do |t|
    t.integer "offer_id"
    t.text "client_items"
    t.text "performer_items"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offer_id"], name: "index_arrangements_on_offer_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string "bank_name"
    t.string "bank_branch"
    t.string "bank_branch_code"
    t.string "bank_type"
    t.string "bank_number"
    t.string "bank_owner"
    t.string "bank_owner_kana"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_banks_on_user_id"
  end

  create_table "basics", force: :cascade do |t|
    t.string "lastname"
    t.string "firstname"
    t.string "lastname_kana"
    t.string "firstname_kana"
    t.string "company"
    t.string "department"
    t.string "phone"
    t.string "zipcode"
    t.string "pref"
    t.string "city"
    t.string "street"
    t.string "bldg"
    t.string "id_front"
    t.string "id_back"
    t.string "company_certification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "profile_photo"
    t.string "cover_photo"
    t.index ["user_id"], name: "index_basics_on_user_id"
  end

  create_table "cancelled_offers", force: :cascade do |t|
    t.integer "offer_id"
    t.integer "cancelled_by"
    t.text "cause"
    t.integer "payback_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "paid_to_client"
    t.integer "pay_amount_to_client"
    t.boolean "paid_to_performer"
    t.integer "pay_amount_to_performer"
    t.integer "recieved_amount"
    t.integer "deposit_for_performer"
    t.integer "profit"
    t.index ["offer_id"], name: "index_cancelled_offers_on_offer_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.integer "contact_id"
    t.integer "from"
    t.integer "to"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "offer_id"
    t.index ["contact_id"], name: "index_chat_messages_on_contact_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "performer"
    t.integer "user1"
    t.integer "user2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "offer_id"
    t.index ["offer_id"], name: "index_contacts_on_offer_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "estimations", force: :cascade do |t|
    t.integer "offer_id"
    t.integer "guarantee"
    t.integer "staff"
    t.integer "withholding_tax"
    t.integer "system_fee"
    t.integer "transport"
    t.integer "accommodation"
    t.integer "carriage"
    t.integer "equipment"
    t.integer "other_expenses"
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "consumption_tax"
    t.index ["offer_id"], name: "index_estimations_on_offer_id"
  end

  create_table "favorite_performers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "performer"
    t.boolean "favorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favorite_performers_on_user_id"
  end

  create_table "helps", force: :cascade do |t|
    t.text "title"
    t.integer "category"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "screenshot"
  end

  create_table "inquiries", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "category"
    t.text "content"
    t.boolean "closed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "musician_profiles", force: :cascade do |t|
    t.string "musician_name"
    t.string "musician_class"
    t.string "instrument1"
    t.string "instrument2"
    t.string "profile_photo"
    t.text "profile_short"
    t.text "profile_long"
    t.text "sample_movie_url1"
    t.text "sample_movie_url2"
    t.integer "basic_guarantee"
    t.text "play_condition"
    t.text "play_condition_detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "cover_photo"
    t.text "sample_movie_url3"
    t.string "area"
    t.index ["user_id"], name: "index_musician_profiles_on_user_id"
  end

  create_table "name_card_orders", force: :cascade do |t|
    t.integer "name_card_id"
    t.integer "amount"
    t.date "delivery_date"
    t.integer "price"
    t.integer "payment_option"
    t.date "payment_limit"
    t.boolean "paid"
    t.string "zipcode"
    t.string "pref"
    t.string "city"
    t.string "street"
    t.string "bldg"
    t.string "reciever_name"
    t.boolean "ordered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name_card_id"], name: "index_name_card_orders_on_name_card_id"
  end

  create_table "name_cards", force: :cascade do |t|
    t.integer "performer_profile_id"
    t.string "your_part"
    t.string "your_name"
    t.string "your_name_kana"
    t.string "your_group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["performer_profile_id"], name: "index_name_cards_on_performer_profile_id"
  end

  create_table "offers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "client"
    t.integer "contractor"
    t.integer "offered_performer"
    t.integer "offer_status"
    t.integer "last_update_from"
    t.datetime "meeting_time"
    t.boolean "meeting_time_confirmed"
    t.datetime "release_time"
    t.boolean "release_time_confirmed"
    t.integer "playing_time"
    t.boolean "playing_time_confirmed"
    t.string "place"
    t.text "dresscode"
    t.text "contract"
    t.text "request_from_client"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.text "equipments"
    t.text "rehearsal"
    t.text "carry_in"
    t.text "parking"
    t.text "dressing_room"
    t.text "stage"
    t.text "accommodation"
    t.text "other_condition"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "offer_id"
    t.integer "total"
    t.integer "guarantee"
    t.integer "management_fee"
    t.integer "staff"
    t.integer "consumption_tax"
    t.integer "withholding_tax"
    t.string "card"
    t.integer "transfer_fee"
    t.integer "system_fee"
    t.integer "payment_options"
    t.datetime "payment_due"
    t.boolean "paid"
    t.datetime "recieved_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transport"
    t.integer "accommodation"
    t.integer "carriage"
    t.integer "equipment"
    t.integer "other_expenses"
    t.datetime "charged_at"
    t.text "detail"
    t.index ["offer_id"], name: "index_payments_on_offer_id"
  end

  create_table "performer_profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "performer_name"
    t.string "performer_rank"
    t.string "genre"
    t.string "area"
    t.integer "number_of_member"
    t.text "profile_short"
    t.text "profile_long"
    t.integer "basic_guarantee"
    t.text "conditions"
    t.text "conditions_detail"
    t.text "sample_movie_url1"
    t.text "sample_movie_url2"
    t.text "sample_movie_url3"
    t.string "profile_photo"
    t.string "cover_photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "set_of_instruments"
    t.boolean "certified"
    t.boolean "published"
    t.index ["user_id"], name: "index_performer_profiles_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "offer_id"
    t.integer "reviewee"
    t.integer "reviewer"
    t.float "total_review"
    t.float "quality"
    t.float "confortability"
    t.float "manners"
    t.float "cost_performance"
    t.float "fast_response"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "report"
    t.text "feedback"
    t.index ["offer_id"], name: "index_reviews_on_offer_id"
  end

  create_table "screenshots", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_type"
    t.boolean "rule_confirmation"
    t.boolean "admin"
    t.boolean "certified"
    t.string "encrypted_otp_secret"
    t.string "encrypted_otp_secret_iv"
    t.string "encrypted_otp_secret_salt"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
