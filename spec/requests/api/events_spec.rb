# frozen_string_literal: true

RSpec.describe 'Api::Events' do
  describe 'GET /api/events' do
    let(:do_request) { get api_events_path, params: { doctor_id: } }
    let(:doctor_john) { create(:doctor) }
    let(:doctor_jane) { create(:doctor) }
    let(:doctor_id) { '' }

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
  end
end
