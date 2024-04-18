class CreateProceedings < ActiveRecord::Migration[7.1]
  def change
    create_table :proceedings, id: :uuid do |t|
      t.references :appointment, null: false, foreign_key: true, type: :uuid
      t.references :patient, null: false, foreign_key: true, type: :uuid
      t.decimal :price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
