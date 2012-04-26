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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120424141921) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "answers", :force => true do |t|
    t.integer  "phase_edition_instance_id"
    t.integer  "question_id"
    t.integer  "dcc_question_id"
    t.text     "answer"
    t.boolean  "answered",                  :default => false
    t.boolean  "hidden",                    :default => false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["phase_edition_instance_id"], :name => "index_answers_on_phase_edition_instance_id"
  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "boilerplate_texts", :force => true do |t|
    t.integer  "boilerplate_id"
    t.string   "boilerplate_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "boilerplate_texts", ["boilerplate_id", "boilerplate_type"], :name => "index_boilerplate_texts_on_boilerplate_id_and_boilerplate_type"

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.string   "symbol"
    t.string   "iso_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.string   "edition"
    t.text     "description"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.boolean  "visible",                 :default => true
    t.integer  "position",                :default => 0
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.integer  "organisation_id"
    t.string   "locale",                  :default => "en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["organisation_id"], :name => "index_documents_on_organisation_id"

  create_table "editions", :force => true do |t|
    t.integer  "phase_id"
    t.string   "edition",        :default => "1.0"
    t.integer  "status",         :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dcc_edition_id"
  end

  add_index "editions", ["dcc_edition_id"], :name => "index_editions_on_dcc_edition_id"
  add_index "editions", ["phase_id"], :name => "index_editions_on_phase_id"

  create_table "guides", :force => true do |t|
    t.integer  "guidance_id"
    t.string   "guidance_type"
    t.text     "guidance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guides", ["guidance_id", "guidance_type"], :name => "index_guides_on_guidance_id_and_guidance_type", :unique => true

  create_table "mappings", :force => true do |t|
    t.integer  "question_id"
    t.integer  "dcc_question_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mappings", ["dcc_question_id"], :name => "index_mappings_on_dcc_question_id"
  add_index "mappings", ["question_id", "dcc_question_id"], :name => "index_mappings_on_question_id_and_dcc_question_id", :unique => true
  add_index "mappings", ["question_id"], :name => "index_mappings_on_question_id"

  create_table "organisation_types", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisations", :force => true do |t|
    t.string   "full_name"
    t.string   "domain"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "url"
    t.integer  "organisation_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "default_locale"
    t.integer  "dcc_edition_id"
    t.string   "stylesheet_file_name"
    t.string   "stylesheet_content_type"
    t.integer  "stylesheet_file_size"
    t.datetime "stylesheet_updated_at"
    t.string   "short_name"
  end

  add_index "organisations", ["dcc_edition_id"], :name => "index_organisations_on_dcc_edition_id"
  add_index "organisations", ["organisation_type_id"], :name => "index_organisations_on_organisation_type_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "slug"
    t.integer  "menu",            :default => 0,    :null => false
    t.integer  "position",        :default => 0,    :null => false
    t.string   "target_url"
    t.integer  "organisation_id",                   :null => false
    t.string   "locale",          :default => "en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["organisation_id"], :name => "index_pages_on_organisation_id"

  create_table "phase_edition_instances", :force => true do |t|
    t.integer  "template_instance_id"
    t.integer  "edition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sword_edit_uri"
  end

  add_index "phase_edition_instances", ["edition_id"], :name => "index_phase_edition_instances_on_edition_id"
  add_index "phase_edition_instances", ["template_instance_id"], :name => "index_phase_edition_instances_on_template_instance_id"

  create_table "phases", :force => true do |t|
    t.integer  "template_id"
    t.string   "phase"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phases", ["template_id"], :name => "index_phases_on_template_id"

  create_table "plans", :force => true do |t|
    t.string   "project"
    t.integer  "currency_id"
    t.float    "budget"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "lead_org"
    t.string   "other_orgs"
    t.boolean  "locked",      :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plans", ["currency_id"], :name => "index_plans_on_currency_id"
  add_index "plans", ["user_id"], :name => "index_plans_on_user_id"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.string   "locale",          :default => "en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "questions", :force => true do |t|
    t.integer  "edition_id"
    t.string   "kind",                   :limit => 1
    t.string   "number_style",           :limit => 1
    t.text     "question"
    t.text     "default_value"
    t.integer  "dependency_question_id"
    t.string   "dependency_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  add_index "questions", ["dependency_question_id"], :name => "index_questions_on_dependency_question_id"
  add_index "questions", ["edition_id"], :name => "index_questions_on_edition_id"

  create_table "roles", :force => true do |t|
    t.integer  "role_flags"
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["organisation_id"], :name => "index_roles_on_organisation_id"
  add_index "roles", ["user_id"], :name => "index_roles_on_user_id"

  create_table "template_instance_rights", :force => true do |t|
    t.integer  "template_instance_id"
    t.string   "email_mask"
    t.integer  "role_flags"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "template_instance_rights", ["template_instance_id"], :name => "index_template_instance_rights_on_template_instance_id"

  create_table "template_instances", :force => true do |t|
    t.integer  "template_id"
    t.integer  "plan_id"
    t.integer  "current_edition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sword_col_uri"
  end

  add_index "template_instances", ["current_edition_id"], :name => "index_template_instances_on_current_edition_id"
  add_index "template_instances", ["plan_id"], :name => "index_template_instances_on_plan_id"
  add_index "template_instances", ["template_id"], :name => "index_template_instances_on_template_id"

  create_table "templates", :force => true do |t|
    t.integer  "organisation_id"
    t.string   "name"
    t.string   "url"
    t.text     "description"
    t.integer  "constraint_limit"
    t.boolean  "checklist",        :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sword_sd_uri"
    t.string   "constraint_text"
  end

  add_index "templates", ["organisation_id"], :name => "index_templates_on_organisation_id"

  create_table "tracks", :force => true do |t|
    t.string   "table"
    t.integer  "row_id"
    t.string   "event"
    t.integer  "user_id"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["user_id"], :name => "index_tracks_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organisation_id"
    t.string   "password_salt"
    t.integer  "failed_attempts",                       :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "user_types",                            :default => 0
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["organisation_id"], :name => "index_users_on_organisation_id"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
