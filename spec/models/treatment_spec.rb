# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Treatment do
  describe 'associations' do
    it { is_expected.to belong_to(:patient) }
  end

  describe 'validations' do
    it 'validates status enum values' do
      enum_values = {
        pending: 'pending', running: 'running', done: 'done', expired: 'expired'
      }
      expect(described_class.new).to define_enum_for(:status)
        .with_values(**enum_values).backed_by_column_of_type(:string)
    end
  end
end
