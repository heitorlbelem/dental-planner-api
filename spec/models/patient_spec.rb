# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Patient do
  let(:patient) { build(:patient) }

  describe 'associations' do
    it { is_expected.to have_one(:address).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }

    context 'when cpf is invalid' do
      it 'adds an invalid error on cpf' do
        patient.cpf = '00000000000'
        patient.validate
        expect(patient.errors[:cpf]).to include("isn't valid")
      end
    end

    context 'when cpf is valid' do
      it 'does not add an error on cpf' do
        patient.validate
        expect(patient.errors[:cpf]).to be_empty
      end
    end

    context 'when cpf has already been taken' do
      it 'adds an uniqueness error on cpf' do
        create(:patient, cpf: '012.345.678-90')
        patient = build(:patient, cpf: '012.345.678-90')
        patient.validate
        expect(patient.errors[:cpf]).to include('has already been taken')
      end
    end
  end

  describe '.filter_by_name' do
    before do
      create_list(:patient, 10, name: 'Patient Test')
      create(:patient, name: 'John Doe Test')
    end

    it 'returns the patients filtered by name' do
      patients = described_class.filter_by_name('John Doe')
      expect(patients.count).to equal(1)
    end
  end
end
