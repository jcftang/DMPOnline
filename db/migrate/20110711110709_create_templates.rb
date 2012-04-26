class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.references :organisation
      t.string :short_name
      t.string :full_name
      t.string :url
      t.text :description
      t.integer :page_limit
      t.boolean :checklist, :default => false

      t.timestamps
    end
    add_index :templates, :organisation_id
  end
end
