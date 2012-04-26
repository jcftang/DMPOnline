class AddSwordToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :sword_sd_uri, :string
  end
end
