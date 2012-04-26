class AddSwordToTemplateInstance < ActiveRecord::Migration
  def change
    add_column :template_instances, :sword_col_uri, :string
  end
end
