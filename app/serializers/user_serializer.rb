class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :role

  attribute :full_name

  def full_name
    "#{first_name.capitalize!} #{last_name.capitalize!}"
  end
end
