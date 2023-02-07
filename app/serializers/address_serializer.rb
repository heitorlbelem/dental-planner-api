# frozen_string_literal: true

class AddressSerializer < ActiveModel::Serializer
  attributes :zip_code, :street, :number, :neighborhood, :state, :city,
    :complement, :created_at, :updated_at
end
