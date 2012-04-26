class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :slug
      t.integer :menu, :default => 0, :null => false
      t.integer :position, :default => 0, :null => false
      t.string :target_url
      t.references :organisation, :null => false
      t.string :locale, :default => I18n.default_locale

      t.timestamps
    end
    add_index :pages, :organisation_id
  end
end
