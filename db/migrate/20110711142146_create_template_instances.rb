class CreateTemplateInstances < ActiveRecord::Migration
  def change
    create_table :template_instances do |t|
      t.references :template
      t.references :plan
      t.references :current_edition # Current Phase Edition

      t.timestamps
    end
    add_index :template_instances, :template_id
    add_index :template_instances, :plan_id
    add_index :template_instances, :current_edition_id
  end
end
