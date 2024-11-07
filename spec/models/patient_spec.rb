# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Patient do
  describe 'validations' do
    subject { build(:patient) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }

    it 'is not valid with invalid brazilian citizen ID' do
      patient = build(:patient, cpf: '00000000000')
      expect(patient).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_one(:address) }
  end
end
