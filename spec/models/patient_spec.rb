# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Patient do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_uniqueness_of(:cpf) }
    it { is_expected.to validate_uniqueness_of(:email) }

    it 'is not valid with invalid brazilian citizen ID' do
      patient = build(:patient, cpf: '00000000000')
      expect(patient).not_to be_valid
    end

    it 'is valid with valid attributes' do
      patient = build(:patient)
      expect(patient).to be_valid
    end
  end
end
