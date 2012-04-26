class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :edition
      t.integer :kind
      t.integer :number_style
      t.text :question
      t.text :default_value
      t.references :dependency_question
      t.string :dependency_value
      t.integer :position

      t.timestamps
    end
    add_index :questions, :edition_id
    add_index :questions, :dependency_question_id
  end
end
