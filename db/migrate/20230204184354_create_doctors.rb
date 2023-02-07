class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors, id: :uuid do |t|
      t.string :expertise, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
