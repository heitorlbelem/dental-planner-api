class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors, id: :uuid do |t|
      t.string :name, null: false
      t.string :expertise, null: false

      t.timestamps
    end
  end
end
