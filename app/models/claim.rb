# frozen_string_literal: true

class Claim < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
