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

ActiveRecord::Schema.define(version: 2021_02_23_032327) do

  create_table "applicants", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_applicants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_applicants_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.string "address"
    t.string "cnpj"
    t.string "site"
    t.string "social_media"
    t.string "domain"
    t.integer "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employee_id"], name: "index_companies_on_employee_id"
  end

  create_table "companies_employees", id: false, force: :cascade do |t|
    t.integer "employee_id", null: false
    t.integer "company_id", null: false
    t.index ["company_id", "employee_id"], name: "index_companies_employees_on_company_id_and_employee_id"
    t.index ["employee_id", "company_id"], name: "index_companies_employees_on_employee_id_and_company_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true
  end

  create_table "job_ads", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.integer "salary_range"
    t.integer "level"
    t.date "mandatory_requirements"
    t.integer "total_vacancy"
    t.integer "company_id", null: false
    t.integer "employee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_job_ads_on_company_id"
    t.index ["employee_id"], name: "index_job_ads_on_employee_id"
  end

  add_foreign_key "companies", "employees"
  add_foreign_key "job_ads", "companies"
  add_foreign_key "job_ads", "employees"
end
