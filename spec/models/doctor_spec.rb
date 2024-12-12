# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Doctor do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:expertise) }
  end

  describe '.filter_by_name' do
    before do
      create_list(:doctor, 10, name: 'Doctor Test')
      create(:doctor, name: 'John Doe Test')
    end

    it 'returns the doctors filtered by name' do
      patients = described_class.filter_by_name('John Doe')
      expect(patients.count).to equal(1)
    end
  end
end
