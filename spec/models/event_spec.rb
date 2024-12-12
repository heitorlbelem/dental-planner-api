# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { build(:event) }

  describe 'associations' do
    it { is_expected.to belong_to(:doctor) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }

    context 'when validating start_time' do
      let(:event) { build(:event, start_time:) }

      context 'when start_time is in the past' do
        let(:start_time) { 1.day.ago }

        it 'is not valid', :aggregate_failures do
          expect(event).not_to be_valid
          expect(event.errors[:start_time]).to include('invalid date to create an event')
        end
      end

      context 'when start_time is in the future' do
        let(:start_time) { 1.day.from_now }

        it 'is valid' do
          expect(event).to be_valid
        end
      end
    end
  end

  describe 'callbacks' do
    context 'when duration is present' do
      it 'calculates end_time based on start_time and duration' do
        event = build(:event, start_time: Time.current, duration: 60)
        event.validate

        expect(event.end_time).to eq(event.start_time + 60.minutes)
      end

      it 'is not valid with negative values', :aggregate_failures do
        event = build(:event, start_time: Time.current, duration: -30)
        event.validate

        expect(event).not_to be_valid
        expect(event.errors[:end_time]).to include("can't be before the start_time")
      end
    end

    context 'when duration is not present' do
      context 'when end_time is not present' do
        let(:event) { build(:event, duration: nil, end_time: nil) }

        it 'is not valid', :aggregate_failures do
          event.validate

          expect(event).not_to be_valid
          expect(event.errors[:end_time]).to include("can't be blank")
        end
      end

      context 'when end_time is present' do
        let(:event) { build(:event, duration: nil) }

        it 'is valid' do
          event.validate

          expect(event).to be_valid
        end
      end
    end
  end

  describe '.filter_by_doctor_id' do
    let(:doctor_john) { create(:doctor) }
    let(:doctor_jane) { create(:doctor) }

    before do
      create(:appointment, start_time: 1.hour.from_now, duration: 20,
        doctor_id: doctor_john.id)
      create(:block, start_time: 2.hours.from_now, end_time: 3.hours.from_now,
        doctor_id: doctor_john.id)
      create(:appointment, start_time: 1.hour.from_now, duration: 20,
        doctor_id: doctor_jane.id)
    end

    it 'returns the events filtered by doctor_id' do
      events = described_class.filter_by_doctor_id(doctor_john.id)
      expect(events.count).to equal(2)
    end
  end

  describe '.filter_by_date_range' do
    before do
      create(:appointment, start_time: 1.day.from_now, duration: 20)
      create(:appointment, start_time: 3.days.from_now, duration: 20)
      create(:appointment, start_time: 4.days.from_now, duration: 20)
    end

    it 'returns the events filtered by date range' do
      start_date = Time.current.to_s
      end_date = 2.days.from_now.to_s
      events = described_class.filter_by_date_range(start_date, end_date)
      expect(events.count).to equal(1)
    end
  end
end
