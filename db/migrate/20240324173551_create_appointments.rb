class CreateAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :appointments, id: :uuid do |t|
      t.references :doctor, null: false, foreign_key: true, type: :uuid
      t.references :patient, null: false, foreign_key: true, type: :uuid
      t.datetime :started_at
      t.integer :duration, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
