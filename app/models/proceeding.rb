# frozen_string_literal: true

class Proceeding < ApplicationRecord
  audited

  belongs_to :appointment, optional: true
  belongs_to :patient
  belongs_to :treatment, optional: true
  belongs_to :product

  validates :price, presence: true
end
