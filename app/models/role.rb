# frozen_string_literal: true

class Role < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :abilities, dependent: :destroy
  has_many :claims, through: :abilities, dependent: :destroy
end
