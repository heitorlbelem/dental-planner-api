# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Appointment do
  describe 'associations' do
    it { is_expected.to belong_to(:doctor) }
    it { is_expected.to belong_to(:patient) }
  end

  describe 'validations' do
    let(:appointment) { described_class.new }
    let(:enum_values) do
      { pending: 'pending', running: 'running', done: 'done', canceled: 'canceled' }
    end

    it { is_expected.to validate_presence_of(:duration_in_minutes) }

    it 'defines the correct statuses' do
      expect(appointment).to define_enum_for(:status)
        .with_values(**enum_values).backed_by_column_of_type(:string)
    end

    it 'defines the correct default status' do
      expect(appointment).to be_pending
    end
  end
end
