# frozen_string_literal: true

class Proceeding < ApplicationRecord
  belongs_to :appointment
  belongs_to :patient

  validates :price, presence: true
end
