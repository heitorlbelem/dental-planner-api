# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Events' do
  describe 'GET /api/events' do
    let(:do_request) do
      get api_events_path, params: { doctor_id:, start_date:, end_date: }
    end
    let(:doctor_john) { create(:doctor) }
    let(:doctor_jane) { create(:doctor) }
    let(:doctor_id) { nil }
    let(:start_date) { nil }
    let(:end_date) { nil }

    before do
      create(:appointment, start_time: 1.hour.from_now, doctor_id: doctor_john.id)
      create(:appointment, start_time: 2.hours.from_now, doctor_id: doctor_john.id)
      create(:block, start_time: 3.hours.from_now, doctor_id: doctor_john.id)
      create(:appointment, start_time: 1.hour.from_now, doctor_id: doctor_jane.id)
    end

    it 'returns http status Ok' do
      do_request
      expect(response).to have_http_status(:ok)
    end

    it 'returns an array containing all the events' do
      do_request
      expect(json[:events].count).to eq(Event.count)
    end

    context 'when filtering by doctor_id' do
      let(:doctor_id) { doctor_john.id }

      it 'returns an array of filtered events' do
        do_request
        expect(json[:events].count).to eq(3)
      end
    end

    context 'when filtering by date range' do
      before do
        create(:appointment, start_time: 2.days.from_now, duration: 20)
        create(:appointment, start_time: 3.days.from_now, duration: 20)
      end

      let(:start_date) { 2.days.from_now.beginning_of_day }
      let(:end_date) { 4.days.from_now.beginning_of_day }

      it 'returns an array of filtered events' do
        do_request
        expect(json[:events].count).to eq(2)
      end
    end
  end

  describe 'DELETE /api/events/:id' do
    let(:do_request) { delete api_event_path(id:) }
    let(:create_event) { create(:appointment) }
    let(:id) { create_event.id }

    it 'returns http status no content' do
      create_event
      do_request
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the requested event' do
      create_event
      expect { do_request }.to change(Event, :count).by(-1)
    end
  end
end
