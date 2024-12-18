# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Doctors' do
  describe 'GET /api/doctors' do
    let(:do_request) { get api_doctors_path, params: { page:, per_page: } }
    let(:doctors_list_count) { 4 }
    let(:page) { 1 }
    let(:per_page) { 10 }

    before { create_list(:doctor, doctors_list_count) }

    it 'returns http status Ok' do
      do_request
      expect(response).to have_http_status(:ok)
    end

    it 'returns an array containing all the doctors' do
      do_request
      expect(json[:doctors].count).to eq(Doctor.count)
    end

    it 'returns the pagination info', :aggregate_failures do
      do_request
      expect(json[:pagination][:page_index]).to eq(1)
      expect(json[:pagination][:total_count]).to eq(doctors_list_count)
    end

    context 'when validating the pagination functionality' do
      let(:doctors_list_count) { 30 }
      let(:per_page) { 5 }

      it 'returns the correct number of doctors per page' do
        do_request
        expect(json[:doctors].count).to eq(per_page)
      end
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
      let(:payload) { { name: 'John Doe', expertise: expected_doctor.expertise } }

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:created)
      end

      it 'creates a new doctor' do
        expect { do_request }.to change(Doctor, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:payload) { { expertise: expected_doctor.expertise } }

      context 'without expertise' do
        let(:expected_doctor) { build(:doctor, expertise: '') }

        it 'returns http status code unprocessable entity' do
          do_request

          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns a json object containing the model errors', :aggregate_failures do
          do_request

          expect(json.keys).to include(:expertise)
          expect(json[:expertise]).to include("can't be blank")
        end

        it "doesn't create a new doctor" do
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
        name: doctor.name,
        expertise: doctor.expertise
      }
    end

    context 'with valid id' do
      it 'returns http status OK' do
        do_request
        expect(response).to have_http_status(:ok)
      end

      it 'returns the searched doctor with expected attributes' do
        do_request
        expect(json[:doctor]).to eq(expected_doctor.merge(id:))
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
      let(:payload) { { expertise: } }

      it 'returns http status code OK' do
        do_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated object' do
        do_request

        expect(json[:doctor][:expertise]).to eq(expertise)
      end

      it 'updates the selected doctor' do
        expect { do_request }.to change { doctor.reload.expertise }.to expertise
      end
    end

    context 'with invalid params' do
      let(:expertise) { '' }
      let(:payload) { { expertise: '' } }

      it 'returns http status code unprocessable entity' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an object containing the model errors', :aggregate_failures do
        do_request

        expect(json.keys).to include(:expertise)
        expect(json[:expertise]).to include("can't be blank")
      end

      it "doesn't update the doctor's expertise" do
        expect { do_request }.not_to(change { doctor.reload.expertise })
      end
    end

    context 'with invalid id' do
      let(:id) { 'invalid id' }
      let(:expertise) { 'expertise' }
      let(:payload) { { expertise: } }

      it 'returns http status not found' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE /api/doctors/:id' do
    let(:doctor) { create(:doctor) }
    let(:id) { doctor.id }
    let(:do_request) { delete api_doctor_path(id) }

    before { doctor }

    context 'with valid id' do
      it 'returns http status code no content' do
        do_request
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes the doctor from the database' do
        expect { do_request }.to change(Doctor, :count).by(-1)
      end
    end
  end
end
