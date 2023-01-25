# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :patient

  validates :zip_code, :full_name, :district, :state, :city, presence: true
end
