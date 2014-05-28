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

ActiveRecord::Schema.define(version: 20140528234655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ldis", force: true do |t|
    t.string   "nombre"
    t.string   "categoria"
    t.text     "descripcion"
    t.string   "telefono"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poblacions", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "situados", force: true do |t|
    t.string   "direccion"
    t.string   "cod_postal"
    t.integer  "poblacion_id"
    t.integer  "ldi_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "situados", ["poblacion_id", "ldi_id"], name: "index_situados_on_poblacion_id_and_ldi_id", unique: true, using: :btree

  create_table "usuarios", force: true do |t|
    t.string   "nombre"
    t.string   "apellidos"
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree

end
