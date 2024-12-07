# frozen_string_literal: true

require 'cpf_cnpj'

class Patient < ApplicationRecord
  has_one :address, dependent: :destroy

  scope :filter_by_name, lambda { |name|
    tokens = name.split.map { |token| "%#{sanitize_sql_like(token)}%" }
    where(tokens.map do |_token|
            'unaccent(name) ILIKE unaccent(?)'
          end.join(' AND '), *tokens)
  }

  validates :name, :phone, presence: true
  validates :cpf, uniqueness: true
  validates_each :cpf, if: -> { cpf.present? } do |record, attr, value|
    record.errors.add(attr, "isn't valid") unless CPF.valid?(value)
  end

  before_validation :normalize_cpf

  # TODO: Regra de negócio fica aqui por enquanto
  def replace_address(attributes = nil)
    transaction do
      address&.destroy!
      create_address!(attributes)
      [address, true]
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed
    [address, false]
  end

  private

  def normalize_cpf
    self.cpf = CPF.format(cpf) if cpf.present?
  end
end
