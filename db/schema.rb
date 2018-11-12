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

ActiveRecord::Schema.define(version: 2018_11_05_095533) do

  create_table "exams", force: :cascade do |t|
    t.string "title"
    t.integer "status"
    t.integer "room_id"
    t.integer "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_exams_on_room_id"
    t.index ["teacher_id"], name: "index_exams_on_teacher_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "text"
    t.string "question_type"
    t.string "answer"
    t.integer "exam_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_questions_on_exam_id"
  end

  create_table "results", force: :cascade do |t|
    t.integer "question_id"
    t.integer "judge"
    t.integer "challenge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_results_on_question_id"
  end

  create_table "states", force: :cascade do |t|
    t.integer "student_id"
    t.string "q_id"
    t.string "judge"
    t.string "challenge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.string "fullname"
    t.string "username"
    t.string "password_digest"
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_teachers_on_token", unique: true
  end

end
