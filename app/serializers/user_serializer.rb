# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :username, :full_name,
    :email, :created_at, :updated_at

  def full_name
    "#{object.first_name.capitalize} #{object.last_name.capitalize}"
  end
end