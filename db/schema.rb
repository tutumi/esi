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

ActiveRecord::Schema.define(version: 20161124001644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "Curriculums_Users", id: false, force: :cascade do |t|
    t.integer "user_id",       null: false
    t.integer "curriculum_id", null: false
  end

  create_table "course_requirements", force: :cascade do |t|
    t.string   "course_id"
    t.string   "course_requirement"
    t.integer  "is_strong"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "courses", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "id_course"
    t.string   "name"
    t.boolean  "is_mandatory"
    t.integer  "credits"
    t.integer  "ext_credits"
    t.integer  "hours"
    t.string   "nome"
    t.integer  "codcg"
    t.integer  "codcur"
    t.integer  "codhab"
    t.integer  "duracao_min"
    t.integer  "duracao_ideal"
    t.integer  "duracao_max"
    t.integer  "ch_obrigatoria_aula"
    t.integer  "ch_obrigatoria_trab"
    t.integer  "ch_eletiva_aula"
    t.integer  "ch_eletiva_trab"
    t.integer  "ch_livre_aula"
    t.integer  "ch_livre_trab"
    t.integer  "ch_estagio"
    t.integer  "periodo"
    t.index ["codcg", "codcur", "codhab"], name: "index_courses_on_codcg_and_codcur_and_codhab", unique: true, using: :btree
  end

  create_table "curriculums", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "subject_id"
    t.integer  "semestre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tipo"
    t.index ["course_id"], name: "index_curriculums_on_course_id", using: :btree
    t.index ["subject_id"], name: "index_curriculums_on_subject_id", using: :btree
  end

  create_table "curriculums_users", id: false, force: :cascade do |t|
    t.integer "user_id",       null: false
    t.integer "curriculum_id", null: false
  end

  create_table "requisites", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "tipo"
    t.integer  "disciplina_id"
    t.integer  "requisito_id"
    t.index ["course_id"], name: "index_requisites_on_course_id", using: :btree
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "codigo"
    t.string   "nome"
    t.integer  "credito_aula"
    t.integer  "credito_trab"
    t.integer  "carga_horaria"
    t.integer  "carga_estagio"
    t.integer  "carga_pratica"
    t.integer  "carga_aaca"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["codigo"], name: "index_subjects_on_codigo", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "nusp"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.integer  "startYear"
    t.integer  "course_id"
    t.index ["course_id"], name: "index_users_on_course_id", using: :btree
  end

  add_foreign_key "curriculums", "courses"
  add_foreign_key "curriculums", "subjects"
  add_foreign_key "requisites", "courses"
  add_foreign_key "users", "courses"
end
