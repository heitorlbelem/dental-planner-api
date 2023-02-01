class CreateClaims < ActiveRecord::Migration[7.0]
  def change
    create_table :claims, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :claims, :name, unique: true
  end
end
