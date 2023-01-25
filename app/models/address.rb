# frozen_string_literal: true

class Address < ApplicationRecord
  validates :zip_code, :full_name, :district, :state, :city, presence: true
end
