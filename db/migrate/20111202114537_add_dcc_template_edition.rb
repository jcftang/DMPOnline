class AddDccTemplateEdition < ActiveRecord::Migration
  def change
    add_column :organisations, :dcc_edition_id, :integer 
    add_index :organisations, :dcc_edition_id 

    add_column :editions, :dcc_edition_id, :integer 
    add_index :editions, :dcc_edition_id 
  end
end
