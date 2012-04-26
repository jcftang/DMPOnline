class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :table
      t.integer :row_id
      t.string :event
      t.references :user
      t.string :ip_address

      t.timestamps
    end
    add_index :tracks, :user_id
  end
end
