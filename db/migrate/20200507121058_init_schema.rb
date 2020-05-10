class InitSchema < ActiveRecord::Migration[5.2]
  def up
    create_table "active_storage_attachments" do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.integer "record_id", null: false
      t.integer "blob_id", null: false
      t.datetime "created_at", null: false
      t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
      t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    end
    create_table "active_storage_blobs" do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.bigint "byte_size", null: false
      t.string "checksum", null: false
      t.datetime "created_at", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
    end
    create_table "banks" do |t|
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
    create_table "basics" do |t|
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
    create_table "chat_messages" do |t|
      t.integer "contact_id"
      t.integer "from"
      t.integer "to"
      t.text "body"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "offer_id"
      t.index ["contact_id"], name: "index_chat_messages_on_contact_id"
    end
    create_table "contacts" do |t|
      t.integer "livehouse"
      t.integer "user1"
      t.integer "user2"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "user_id"
      t.integer "offer_id"
      t.index ["offer_id"], name: "index_contacts_on_offer_id"
      t.index ["user_id"], name: "index_contacts_on_user_id"
    end
    create_table "donations" do |t|
      t.string "name"
      t.integer "amount"
      t.string "email"
      t.string "phone"
      t.string "zipcode"
      t.string "pref"
      t.string "city"
      t.string "street"
      t.string "bldg"
      t.text "message"
      t.text "bank_address"
      t.boolean "confirmation"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "livehouse_id"
      t.string "nickname"
      t.integer "reciever"
      t.boolean "paid"
    end
    create_table "favorite_livehouses" do |t|
      t.integer "user_id"
      t.integer "livehouse"
      t.boolean "favorite"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_favorite_livehouses_on_user_id"
    end
    create_table "helps" do |t|
      t.text "title"
      t.integer "category"
      t.text "content"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "screenshot"
    end
    create_table "inquiries" do |t|
      t.string "name"
      t.string "email"
      t.integer "category"
      t.text "content"
      t.boolean "closed"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "livehouses" do |t|
      t.integer "user_id"
      t.string "livehouse_name"
      t.string "livehouse_rank"
      t.string "genre"
      t.string "area"
      t.integer "number_of_member"
      t.text "profile_short"
      t.text "profile_long"
      t.integer "required_amount"
      t.text "capacity"
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
      t.string "zipcode"
      t.string "pref"
      t.string "city"
      t.string "street"
      t.string "bldg"
      t.string "shop_email"
      t.string "shop_phone"
      t.string "shop_url"
      t.string "company"
      t.string "owner"
      t.string "manager"
      t.index ["user_id"], name: "index_livehouses_on_user_id"
    end
    create_table "screenshots" do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "taggings" do |t|
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
    create_table "tags" do |t|
      t.string "name"
      t.integer "taggings_count", default: 0
      t.index ["name"], name: "index_tags_on_name", unique: true
    end
    create_table "users" do |t|
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
      t.string "stripe_user_id"
      t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end
