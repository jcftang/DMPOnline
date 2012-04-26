class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.references :guidance, :polymorphic => true
      t.text :guidance

      t.timestamps
    end
    add_index :guides, [:guidance_id, :guidance_type], :unique => true
  end
end
