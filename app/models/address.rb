# frozen_string_literal: true

class Address < ApplicationRecord
  audited

  belongs_to :patient

  validates :zip_code, :street, :number, :neighborhood, :state, :city, presence: true
end
