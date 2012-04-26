class CreatePhaseEditionInstances < ActiveRecord::Migration
  def change
    create_table :phase_edition_instances do |t|
      t.references :template_instance
      t.references :edition

      t.timestamps
    end
    add_index :phase_edition_instances, :template_instance_id
    add_index :phase_edition_instances, :edition_id
  end
end
