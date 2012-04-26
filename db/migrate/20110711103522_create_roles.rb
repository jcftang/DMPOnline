class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :role_flags
      t.references :user
      t.references :organisation

      t.timestamps
    end
    add_index :roles, :user_id
    add_index :roles, :organisation_id
  end
end
