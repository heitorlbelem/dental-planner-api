# frozen_string_literal: true

class Doctor < ApplicationRecord
  audited

  belongs_to :user

  validates :expertise, presence: true
end
