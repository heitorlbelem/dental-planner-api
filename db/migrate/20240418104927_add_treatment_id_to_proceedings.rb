class AddTreatmentIdToProceedings < ActiveRecord::Migration[7.1]
  def change
    add_reference :proceedings, :treatment, foreign_key: true, type: :uuid
  end
end
