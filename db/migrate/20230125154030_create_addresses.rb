class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :zip_code
      t.string :full_name
      t.string :complement
      t.string :neighborhood
      t.string :state
      t.string :city

      t.timestamps
    end
  end
end
