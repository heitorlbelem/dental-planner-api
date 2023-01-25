class AddPatientToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :patient, null: false, foreign_key: true
  end
end
