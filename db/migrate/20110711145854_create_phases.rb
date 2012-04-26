class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.references :template
      t.string :phase
      t.integer :position

      t.timestamps
    end
    add_index :phases, :template_id
  end
end
