class CreateBoilerplateTexts < ActiveRecord::Migration
  def change
    create_table :boilerplate_texts do |t|
      t.references :boilerplate, :polymorphic => true
      t.text :content

      t.timestamps
    end
    add_index :boilerplate_texts, [:boilerplate_id, :boilerplate_type]
  end
end
