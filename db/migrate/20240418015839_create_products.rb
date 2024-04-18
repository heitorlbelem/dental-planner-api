class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid do |t|
      t.decimal :default_price, precision: 10, scale: 2, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
