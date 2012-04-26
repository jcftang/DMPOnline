class AddDefaultLocaleToOrganisation < ActiveRecord::Migration
  def change
    add_column :organisations, :default_locale, :string
  end
end
