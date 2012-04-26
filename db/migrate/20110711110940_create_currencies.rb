class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :symbol
      t.string :iso_code

      t.timestamps
    end
  end
end
