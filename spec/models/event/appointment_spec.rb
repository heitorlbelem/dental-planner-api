# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event::Appointment, type: :model do
  subject { build(:appointment) }

  describe 'associations' do
    it { is_expected.to belong_to(:patient) }
  end

  describe 'validations' do
    context 'when validating doctor availability' do
      it 'is not valid when schedule for a blocked period', :aggregate_failures do
        doctor = create(:doctor)
        block_start = 1.hour.from_now
        block_end = 2.hours.from_now
        create(:block, doctor:, start_time: block_start, end_time: block_end)
        patient = create(:patient)
        start_time = block_start + 30.minutes
        appointment = build(:appointment, start_time:, duration: 30, doctor:, patient:)
        expect(appointment).not_to be_valid
        expect(appointment.errors[:base]).to include('this time period is not available for this doctor')
      end

      it 'is not valid when schedule with an overlapping appointment', :aggregate_failures do
        doctor = create(:doctor)
        start_time = 1.hour.from_now
        create(:appointment, doctor:, start_time:, duration: 60)
        start_time += 30.minutes
        patient = create(:patient)
        appointment = build(:appointment, doctor:, patient:, start_time:)
        expect(appointment).not_to be_valid
        expect(appointment.errors[:base]).to include('this time period is not available for this doctor')
      end

      it 'is valid for an available period' do
        doctor = create(:doctor)
        start_time = 1.hour.from_now
        create(:appointment, doctor:, start_time:, duration: 30)
        start_time += 30.minutes
        patient = create(:patient)
        appointment = build(:appointment, doctor:, patient:, start_time:)
        expect(appointment).to be_valid
      end
    end
  end

  describe 'status changes validations' do
    let(:appointment) { create(:appointment) }

    context 'when in pending state' do
      it 'can transition to canceled' do
        appointment.cancel!
        expect(appointment).to be_canceled
      end

      it 'can transition to confirmed' do
        appointment.confirm!
        expect(appointment).to be_confirmed
      end

      it "can't transition to finished" do
        expect { appointment.finish! }.to raise_error(AASM::InvalidTransition)
      end
    end

    context 'when in confirmed state' do
      before { appointment.confirm! }

      it 'can transition to canceled' do
        appointment.cancel!
        expect(appointment).to be_canceled
      end

      it 'can transition to finished' do
        appointment.finish!
        expect(appointment).to be_finished
      end
    end

    context 'when in canceled state' do
      before { appointment.cancel! }

      it "can't transition to another state" do
        expect { appointment.finish! }.to raise_error(AASM::InvalidTransition)
      end
    end

    context 'when in finished state' do
      before do
        appointment.confirm!
        appointment.finish!
      end

      it "can't transition to another state" do
        expect { appointment.cancel! }.to raise_error(AASM::InvalidTransition)
      end
    end
  end
end
