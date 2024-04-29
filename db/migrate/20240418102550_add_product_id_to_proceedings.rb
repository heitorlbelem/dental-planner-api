class AddProductIdToProceedings < ActiveRecord::Migration[7.1]
  def change
    add_reference :proceedings, :product, null: false, foreign_key: true, type: :uuid
  end
end
