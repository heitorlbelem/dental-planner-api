# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Events::Blocks' do
  describe 'POST /api/blocks' do
    let(:do_request) do
      post api_blocks_path,
        params: payload,
        headers:,
        as: :json
    end

    context 'with correct params' do
      let(:doctor) { create(:doctor) }
      let(:payload) do
        {
          doctor_id: doctor.id,
          start_time: 1.hour.from_now,
          end_time: 2.hours.from_now,
          description: 'Out of office'
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:created)
      end

      it 'creates a new block event' do
        expect { do_request }.to change(Event::Block, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:doctor) { create(:doctor) }
      let(:payload) { { doctor_id: doctor.id } }

      it 'returns http status code unprocessable entity' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a json object containing the model errors', :aggregate_failures do
        do_request

        expect(json.keys).to include(:start_time, :end_time)
        expect(json[:start_time]).to include("can't be blank")
      end

      it "doesn't create a new block event" do
        expect { do_request }.not_to change(Event::Block, :count)
      end
    end
  end
end
