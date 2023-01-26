# frozen_string_literal: true

require 'cpf_cnpj'

class Patient < ApplicationRecord
  has_one :address, dependent: :destroy

  validates :name, :phone, :email, :cpf, presence: true
  validates :email, :cpf, uniqueness: true

  validates_each :cpf do |record, attr, value|
    record.errors.add(attr, "isn't valid") unless CPF.valid?(value)
  end

  def replace_address(attributes = nil)
    transaction do
      address&.destroy!
      create_address!(attributes)
      [address, true]
    end
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotDestroyed
    [address, false]
  end
end
