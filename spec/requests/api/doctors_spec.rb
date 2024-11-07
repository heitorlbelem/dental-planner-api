# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Doctors' do
  describe 'GET /api/doctors' do
    let(:do_request) { get api_doctors_path }

    before { create_list(:doctor, 4) }

    it 'returns http status Ok' do
      do_request

      expect(response).to have_http_status(:ok)
    end

    it 'returns an array containing all the doctors' do
      do_request

      expect(json.count).to eq(Doctor.count)
    end
  end

  describe 'POST /api/doctors' do
    let(:do_request) do
      post api_doctors_path,
        params: payload,
        headers:,
        as: :json
    end

    context 'with correct params' do
      let(:expected_doctor) { build(:doctor) }
      let(:user) { create(:user) }

      let(:payload) do
        {
          expertise: expected_doctor.expertise,
          user_id: user.id
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:created)
      end

      it 'creates a new doctor' do
        expect { do_request }.to change(Doctor, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:payload) do
        {
          expertise: expected_doctor.expertise,
          user_id: doctor_user.id
        }
      end

      context 'without expertise' do
        let(:expected_doctor) { build(:doctor, expertise: '') }
        let(:doctor_user) { create(:user) }

        it 'returns http status code unprocessable entity' do
          do_request

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns an json object containing the model errors', :aggregate_failures do
          do_request

          expect(json.keys).to include(:expertise)
          expect(json[:expertise]).to include("can't be blank")
        end

        it 'does not create a new doctor' do
          expect { do_request }.not_to change(Doctor, :count)
        end
      end
    end
  end

  describe 'GET /api/doctors/:id' do
    before { create_list(:doctor, 4) }

    let(:do_request) { get api_doctor_path(id) }
    let(:doctor) { Doctor.first }
    let(:id) { doctor.id }
    let(:expected_doctor) do
      {
        id: doctor.id,
        user_id: doctor.user_id,
        expertise: doctor.expertise,
        created_at: doctor.created_at.iso8601(3),
        updated_at: doctor.updated_at.iso8601(3)
      }
    end

    context 'with valid id' do
      it 'returns http status OK' do
        do_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns the searched doctor with expected attributes' do
        do_request

        expect(json).to eq(expected_doctor.merge(id:))
      end
    end

    context 'with invalid id' do
      let(:id) { 0 }

      it 'returns http status not found' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT /api/doctors/:id' do
    let(:do_request) do
      put api_doctor_path(id),
        params: payload,
        headers:,
        as: :json
    end
    let(:doctor) { create(:doctor) }
    let(:id) { doctor.id }

    before { doctor }

    context 'with valid params' do
      let(:expertise) { 'teste' }
      let(:payload) do
        {
          expertise:
        }
      end

      it 'returns http status code OK' do
        do_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated object' do
        do_request

        expect(json[:expertise]).to eq(expertise)
      end

      it 'updates the selected doctor' do
        expect { do_request }.to change { doctor.reload.expertise }.to expertise
      end
    end

    context 'with invalid params' do
      let(:expertise) { '' }
      let(:payload) do
        {
          expertise: ''
        }
      end

      it 'returns http status code unprocessable entity' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an object containing the model errors', :aggregate_failures do
        do_request

        expect(json.keys).to include(:expertise)
        expect(json[:expertise]).to include("can't be blank")
      end

      it "does not update the doctor's expertise" do
        expect { do_request }.not_to(change { doctor.reload.expertise })
      end
    end

    context 'with invalid id' do
      let(:id) { 'invalid id' }
      let(:expertise) { 'expertise' }
      let(:payload) do
        {
          expertise:
        }
      end

      it 'returns http status not found' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
