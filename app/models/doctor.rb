# frozen_string_literal: true

class Doctor < ApplicationRecord
  validates :expertise, presence: true
end
