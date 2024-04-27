# frozen_string_literal: true

class Product < ApplicationRecord
  validates :default_price, :name, presence: true
end
