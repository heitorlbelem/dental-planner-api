class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.string :phone
      t.string :cpf
      t.string :email
      t.string :birthdate

      t.timestamps
    end

    add_index :patients, :email, unique: true
    add_index :patients, :cpf, unique: true
  end
end
