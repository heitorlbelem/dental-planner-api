# frozen_string_literal: true

class Privilege < ApplicationRecord
  belongs_to :user
  belongs_to :claim
end
