class CreateAbilities < ActiveRecord::Migration[7.0]
  def change
    create_table :abilities, id: :uuid do |t|
      t.references :claim, null: false, foreign_key: true, type: :uuid
      t.references :role, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
