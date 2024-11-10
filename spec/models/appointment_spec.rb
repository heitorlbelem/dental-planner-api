# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Appointment do
  subject { build(:appointment) }

  describe 'associations' do
    it { is_expected.to belong_to(:doctor) }
    it { is_expected.to belong_to(:patient) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:duration_in_minutes) }
    it { is_expected.to be_pending }

    it "isn't valid when start_time is in the past" do
      appointment = build(:appointment, start_time: 1.day.ago)
      expect { appointment.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "isn't valid when there is an overlapping appointment for the requested doctor" do
      doctor = create(:doctor)
      start_time = 1.day.from_now
      create(:appointment, doctor:, start_time:)
      appointment = build(:appointment, doctor:, start_time:)
      expect { appointment.save! }.to raise_error(ActiveRecord::RecordInvalid)
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
