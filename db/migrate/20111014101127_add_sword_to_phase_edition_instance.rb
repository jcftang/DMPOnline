class AddSwordToPhaseEditionInstance < ActiveRecord::Migration
  def change
    add_column :phase_edition_instances, :sword_edit_uri, :string
  end
end
