# frozen_string_literal: true

class Doctor < ApplicationRecord
  belongs_to :user

  validates :expertise, presence: true
end
