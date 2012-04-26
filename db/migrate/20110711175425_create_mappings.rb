class CreateMappings < ActiveRecord::Migration
  def change
    create_table :mappings do |t|
      t.references :question
      t.references :dcc_question
      t.integer :position

      t.timestamps
    end
    add_index :mappings, [:question_id, :dcc_question_id], :unique => true
    add_index :mappings, :question_id
    add_index :mappings, :dcc_question_id
  end
end
