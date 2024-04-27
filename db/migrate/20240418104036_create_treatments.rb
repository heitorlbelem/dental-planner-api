class CreateTreatments < ActiveRecord::Migration[7.1]
  def change
    create_table :treatments, id: :uuid do |t|
      t.string :status, null: false
      t.references :patient, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
