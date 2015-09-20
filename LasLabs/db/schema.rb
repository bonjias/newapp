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

ActiveRecord::Schema.define(version: 20140817012241) do

  create_table "authorized_users", force: true do |t|
    t.string   "email"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "shortname",    limit: 5
    t.integer  "toggl_id"
    t.integer  "qb_client_id"
  end

  add_index "companies", ["shortname"], name: "index_companies_on_shortname", using: :btree

  create_table "invoices", force: true do |t|
    t.datetime "start"
    t.datetime "end"
    t.decimal  "total",                 precision: 7, scale: 2
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date"
    t.string   "qb_name",    limit: 20
  end

  add_index "invoices", ["qb_name"], name: "index_invoices_on_qb_name", using: :btree

  create_table "qbos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_entries", force: true do |t|
    t.datetime "start"
    t.datetime "end"
    t.integer  "rate"
    t.text     "description"
    t.string   "tags"
    t.integer  "invoice_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "signature"
  end

  add_index "time_entries", ["signature"], name: "index_time_entries_on_signature", unique: true, using: :btree

  create_table "toggls", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.text     "enc_qbo_token"
    t.text     "enc_qbo_secret"
    t.text     "enc_qbo_company_id"
    t.datetime "qbo_token_exp"
    t.datetime "qbo_reconnect_tok"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
