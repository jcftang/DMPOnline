class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|     
      t.string :name
      t.string :edition
      t.text :description
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at
      t.boolean :visible, :default => true
      t.integer :position, :default => 0
      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_file_size
      t.datetime :icon_updated_at
      t.references :organisation
      t.string :locale, :default => I18n.default_locale

      t.timestamps
    end
    add_index :documents, :organisation_id
  end
end
