# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Patient do
  describe 'validations' do
    subject { build(:patient) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:cpf) }

    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }

    context 'when validates CPF' do
      it 'is not valid with invalid brazilian citizen ID' do
        patient = build(:patient, cpf: '00000000000')
        expect(patient).not_to be_valid
      end

      it 'is valid with valid attributes' do
        patient = build(:patient, cpf: '545.461.862-40')
        expect(patient).to be_valid
      end
    end
  end

  describe 'associations' do
    it { is_expected.to have_one(:address) }
  end
end
