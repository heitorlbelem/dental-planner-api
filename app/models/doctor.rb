# frozen_string_literal: true

class Doctor < ApplicationRecord
  validates :name, :expertise, presence: true
end
