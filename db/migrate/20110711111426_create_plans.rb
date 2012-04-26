class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :project
      t.references :currency
      t.float :budget
      t.date :start_date
      t.date :end_date
#      t.references :organisation, :name => "lead_org"
      t.string :lead_org
      t.string :other_orgs
      t.boolean :locked, :default => false
      t.references :user
      
      t.timestamps
    end
    add_index :plans, :currency_id
#    add_index :plans, :organisation_id
    add_index :plans, :user_id
  end
end
