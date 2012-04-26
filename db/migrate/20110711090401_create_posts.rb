class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|     
      t.string :title
      t.text :body
      t.references :user
      t.references :organisation
      t.string :locale, :default => I18n.default_locale

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
