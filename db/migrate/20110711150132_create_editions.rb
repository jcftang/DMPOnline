class CreateEditions < ActiveRecord::Migration
  def change
    create_table :editions do |t|
      t.references :phase
      t.string :edition, :default => "1.0"
      t.integer :status, :default => 0

      t.timestamps
    end
    add_index :editions, :phase_id
  end
end
