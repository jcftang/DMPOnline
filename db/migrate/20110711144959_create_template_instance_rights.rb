class CreateTemplateInstanceRights < ActiveRecord::Migration
  def change
    create_table :template_instance_rights do |t|
      t.references :template_instance
      t.string :email_mask
      t.integer :role_flags

      t.timestamps
    end
    add_index :template_instance_rights, :template_instance_id
  end
end
