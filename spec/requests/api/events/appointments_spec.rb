# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Events::Appointments' do
  describe 'POST /api/appointments' do
    let(:do_request) do
      post api_appointments_path,
        params: payload,
        headers:,
        as: :json
    end

    context 'with correct params' do
      let(:doctor) { create(:doctor) }
      let(:patient) { create(:patient) }
      let(:payload) do
        {
          doctor_id: doctor.id,
          patient_id: patient.id,
          start_time: 30.days.from_now,
          duration: 30,
          description: 'Lorem Ipsum'
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:created)
      end

      it 'creates a new appointment' do
        expect { do_request }.to change(Event::Appointment, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:doctor) { create(:doctor) }
      let(:patient) { create(:patient) }
      let(:payload) do
        {
          doctor_id: doctor.id,
          patient_id: patient.id
        }
      end

      it 'returns http status code unprocessable entity' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a json object containing the model errors', :aggregate_failures do
        do_request

        expect(json.keys).to include(:start_time, :end_time)
        expect(json[:start_time]).to include("can't be blank")
      end

      it "doesn't create a new appointment" do
        expect { do_request }.not_to change(Event::Appointment, :count)
      end
    end
  end
end
