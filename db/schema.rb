# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_26_154043) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "benefit_summaries", force: :cascade do |t|
    t.bigint "benefit_id", null: false
    t.date "issue_date"
    t.string "number"
    t.string "species"
    t.date "der"
    t.integer "despacho"
    t.integer "motivo"
    t.integer "motivo1"
    t.integer "motivo2"
    t.string "name"
    t.string "sex"
    t.date "birth_date"
    t.string "nit"
    t.string "cpf"
    t.string "mothers_name"
    t.integer "ra"
    t.integer "ff"
    t.date "dib"
    t.date "dip"
    t.date "datdd"
    t.date "data_licenca"
    t.integer "tipo_licenca"
    t.date "dodr"
    t.string "tempo_beneficio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["benefit_id"], name: "index_benefit_summaries_on_benefit_id"
  end

  create_table "benefits", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "insureds", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "mothers_name"
    t.date "birth_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "requeriments", force: :cascade do |t|
    t.integer "protocol"
    t.date "der"
    t.bigint "user_id", null: false
    t.bigint "insured_id", null: false
    t.bigint "benefit_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "servico"
    t.index ["benefit_id"], name: "index_requeriments_on_benefit_id"
    t.index ["insured_id"], name: "index_requeriments_on_insured_id"
    t.index ["user_id"], name: "index_requeriments_on_user_id"
  end

  create_table "rural_document_types", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "document"
  end

  create_table "rural_documents", force: :cascade do |t|
    t.date "issue_date"
    t.date "registration_date"
    t.date "validity_start_date"
    t.date "validity_end_date"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "rural_document_type_id"
    t.index ["rural_document_type_id"], name: "index_rural_documents_on_rural_document_type_id"
  end

  create_table "score_for_services", force: :cascade do |t|
    t.string "servico"
    t.string "status"
    t.boolean "antecipa"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "conclusao"
    t.float "exigencia"
    t.float "subtarefa"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "requeriment_id", null: false
    t.string "servico"
    t.string "status"
    t.float "score"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "work_period_id", null: false
    t.index ["requeriment_id"], name: "index_scores_on_requeriment_id"
    t.index ["work_period_id"], name: "index_scores_on_work_period_id"
  end

  create_table "self_declarations", force: :cascade do |t|
    t.string "type"
    t.bigint "benefit_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["benefit_id"], name: "index_self_declarations_on_benefit_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_periods", force: :cascade do |t|
    t.bigint "user_id"
    t.string "program"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_work_periods_on_user_id"
  end

  add_foreign_key "benefit_summaries", "benefits"
  add_foreign_key "requeriments", "benefits"
  add_foreign_key "requeriments", "insureds"
  add_foreign_key "requeriments", "users"
  add_foreign_key "rural_documents", "rural_document_types"
  add_foreign_key "scores", "requeriments"
  add_foreign_key "scores", "work_periods"
  add_foreign_key "self_declarations", "benefits"
end
