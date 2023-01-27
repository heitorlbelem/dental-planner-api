class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients, id: :uuid do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :cpf, null: false
      t.string :email
      t.string :birthdate

      t.timestamps
    end
  end
end
