class AddConstraintTextToTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :constraint_text, :string
    rename_column :templates, :page_limit, :constraint_limit
  end
end
