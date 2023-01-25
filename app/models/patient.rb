# frozen_string_literal: true

require 'cpf_cnpj'

class Patient < ApplicationRecord
  has_one :address

  validates :name, :phone, :email, :cpf, presence: true
  validates :email, :cpf, uniqueness: true

  validates_each :cpf do |record, attr, value|
    record.errors.add(attr, 'isn`t valid') unless CPF.valid?(value)
  end
end
