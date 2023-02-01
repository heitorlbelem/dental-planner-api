# frozen_string_literal: true

class Claim < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :abilities, dependent: :destroy
  has_many :roles, through: :abilities, dependent: :destroy
end
