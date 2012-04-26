class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :phase_edition_instance
      t.references :question
      t.references :dcc_question
      t.text :answer
      t.boolean :answered, :default => false
      t.boolean :hidden, :default => false
      t.integer :position

      t.timestamps
    end
    add_index :answers, :phase_edition_instance_id
    add_index :answers, :question_id
  end
end
