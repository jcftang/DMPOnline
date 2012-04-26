class AddNestedSetsToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :parent_id, :integer
    add_column :questions, :lft, :integer
    add_column :questions, :rgt, :integer
    change_column :questions, :number_style, :string, :limit => 1
    change_column :questions, :kind, :string, :limit => 1
    remove_column :questions, :position
  end
end
