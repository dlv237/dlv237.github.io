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

ActiveRecord::Schema[7.0].define(version: 2023_10_29_013057) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "califications", force: :cascade do |t|
    t.bigint "usuario_calificador_id", null: false
    t.bigint "usuario_calificado_id", null: false
    t.integer "puntuacion"
    t.text "mensaje"
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_califications_on_product_id"
    t.index ["usuario_calificado_id"], name: "index_califications_on_usuario_calificado_id"
    t.index ["usuario_calificador_id"], name: "index_califications_on_usuario_calificador_id"
  end

  create_table "categoria", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "usuario_id", null: false
    t.bigint "room_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read"
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["usuario_id"], name: "index_messages_on_usuario_id"
  end

  create_table "plataformas", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "nombre", limit: 255
    t.text "descripcion"
    t.string "estado", limit: 255
    t.integer "id_categoria"
    t.integer "id_usuario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.bigint "categoria_id", null: false
    t.bigint "plataforma_id", null: false
    t.index ["categoria_id"], name: "index_products_on_categoria_id"
    t.index ["plataforma_id"], name: "index_products_on_plataforma_id"
  end

  create_table "regions", force: :cascade do |t|
    t.text "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.boolean "is_private", default: false
    t.bigint "usuario_1_id"
    t.bigint "usuario_2_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_1_id"], name: "index_rooms_on_usuario_1_id"
    t.index ["usuario_2_id"], name: "index_rooms_on_usuario_2_id"
  end

  create_table "solicituds", force: :cascade do |t|
    t.bigint "producto_ofrecido_id"
    t.bigint "producto_solicitado_id"
    t.integer "estado"
    t.string "mensaje", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["producto_ofrecido_id"], name: "index_solicituds_on_producto_ofrecido_id"
    t.index ["producto_solicitado_id"], name: "index_solicituds_on_producto_solicitado_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "nombre"
    t.integer "id_region"
    t.integer "id_ciudad"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.datetime "locked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.bigint "region_id"
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["region_id"], name: "index_usuarios_on_region_id"
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  add_foreign_key "califications", "products", on_delete: :cascade
  add_foreign_key "califications", "usuarios", column: "usuario_calificado_id", on_delete: :cascade
  add_foreign_key "califications", "usuarios", column: "usuario_calificador_id", on_delete: :cascade
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "usuarios", on_delete: :cascade
  add_foreign_key "products", "categoria", column: "categoria_id"
  add_foreign_key "products", "plataformas"
  add_foreign_key "rooms", "usuarios", column: "usuario_1_id", on_delete: :cascade
  add_foreign_key "rooms", "usuarios", column: "usuario_2_id", on_delete: :cascade
  add_foreign_key "solicituds", "products", column: "producto_ofrecido_id", on_delete: :cascade
  add_foreign_key "solicituds", "products", column: "producto_solicitado_id", on_delete: :cascade
  add_foreign_key "usuarios", "regions"
end
