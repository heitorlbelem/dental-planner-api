class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events, id: :uuid do |t|
      t.references :doctor, null: false, foreign_key: true, type: :uuid
      t.references :patient, foreign_key: true, type: :uuid
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :type, null: false
      t.string :status

      t.timestamps
    end
  end
end
