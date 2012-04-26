class AddStylesheetToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :stylesheet_file_name, :string 
    add_column :organisations, :stylesheet_content_type, :string 
    add_column :organisations, :stylesheet_file_size, :integer
    add_column :organisations, :stylesheet_updated_at, :datetime 
  end
end
