# frozen_string_literal: true

class Doctor < ApplicationRecord
  belongs_to :user, optional: true

  validates :expertise, presence: true
end
