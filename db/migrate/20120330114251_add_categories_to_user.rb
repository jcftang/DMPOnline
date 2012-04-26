class AddCategoriesToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_types, :integer, :default => 0
  end
end
