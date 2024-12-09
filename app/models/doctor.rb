# frozen_string_literal: true

class Doctor < ApplicationRecord
  scope :filter_by_name, lambda { |name|
    next all if name.blank?

    tokens = name.split.map { |token| "%#{sanitize_sql_like(token)}%" }
    where(tokens.map do |_token|
            'unaccent(name) ILIKE unaccent(?)'
          end.join(' AND '), *tokens)
  }

  validates :name, :expertise, presence: true
end
