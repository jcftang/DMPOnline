class CreateOrganisations < ActiveRecord::Migration
  def change
    create_table :organisations do |t|     
      t.string :name
      t.string :domain
      t.string :logo_file_name
      t.string :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at
      t.string :url
      t.references :organisation_type

      t.timestamps
    end
    add_index :organisations, :organisation_type_id
  end
end
