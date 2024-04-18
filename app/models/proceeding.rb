# frozen_string_literal: true

class Proceeding < ApplicationRecord
  audited

  belongs_to :appointment, optional: true
  belongs_to :patient

  validates :price, presence: true
end
