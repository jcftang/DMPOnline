class MoveShortNameToOrganisation < ActiveRecord::Migration
  def change
    rename_column :templates, :full_name, :name
    rename_column :organisations, :name, :full_name
    add_column    :organisations, :short_name, :string
    remove_column :templates, :short_name
  end
end
