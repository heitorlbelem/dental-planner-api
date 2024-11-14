class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients, id: :uuid do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :cpf
      t.string :email
      t.string :date_of_birth
      t.string :gender

      t.timestamps
    end
  end
end
