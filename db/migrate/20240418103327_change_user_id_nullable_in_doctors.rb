class ChangeUserIdNullableInDoctors < ActiveRecord::Migration[7.1]
  def change
    change_column_null :doctors, :user_id, true
  end
end
