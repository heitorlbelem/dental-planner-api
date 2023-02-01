# frozen_string_literal: true

class Ability < ApplicationRecord
  belongs_to :claim
  belongs_to :role
end
