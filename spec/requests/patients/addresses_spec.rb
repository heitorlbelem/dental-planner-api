# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Patients::Addresses' do
  let(:headers) { { accept: 'application/json' } }
  let(:patient) { create(:patient) }

  before { patient }

  describe 'POST /api/patients/:patient_id/address' do
    let(:do_request) do
      post api_patient_address_path(patient.id),
        params: payload,
        headers: headers
    end

    context 'with correct params' do
      let(:expected_address) { build(:address) }
      let(:payload) do
        {
          address: {
            zip_code: expected_address.zip_code,
            full_name: expected_address.full_name,
            complment: expected_address.complement,
            neighborhood: expected_address.neighborhood,
            state: expected_address.state,
            city: expected_address.city
          }
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:created)
      end

      it 'creates a new address' do
        expect { do_request }.to change(Address, :count).by(1)
      end

      it "creates the patient's address" do
        do_request

        expect(patient.reload.address).to be_present
      end
    end

    context 'with invalid params' do
      let(:invalid_address) { build(:address, zip_code: '') }
      let(:payload) do
        {
          address: {
            zip_code: invalid_address.zip_code,
            full_name: invalid_address.full_name,
            complment: invalid_address.complement,
            neighborhood: invalid_address.neighborhood,
            state: invalid_address.state,
            city: invalid_address.city
          }
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error object with the model error messages' do
        do_request

        expect(json[:errors][:zip_code].first).to eq("can't be blank")
      end

      it 'does not create a new address' do
        expect { do_request }.not_to change(Address, :count)
      end

      it "does not create the patient's address" do
        do_request

        expect(patient.reload.address).to be_nil
      end
    end
  end

  describe 'GET /api/patients/:patient_id/address' do
    let(:do_request) { get api_patient_address_path(patient.id) }
    let(:address) { create(:address, patient_id: patient.id) }
    let(:expected_address) do
      {
        zip_code: address.zip_code,
        full_name: address.full_name,
        neighborhood: address.neighborhood,
        state: address.state,
        city: address.city,
        complement: address.complement
      }
    end

    before { address }

    it 'returns http status OK' do
      do_request

      expect(response).to have_http_status(:ok)
    end

    it 'returns the patient address with expected attributes' do
      do_request

      expect(json[:address]).to eq(expected_address)
    end
  end

  describe 'PUT /api/patients/:patient_id/address' do
    let(:do_request) do
      put api_patient_address_path(patient.id),
        params: payload,
        headers: headers
    end
    let(:address) { create(:address, patient_id: patient.id) }
    let(:zip_code) { 'zip code' }

    before { address }

    context 'with valid attributes' do
      let(:payload) do
        {
          address: {
            zip_code: zip_code
          }
        }
      end

      it 'returns http status OK' do
        do_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated object' do
        do_request

        expect(json[:address][:zip_code]).to eq(zip_code)
      end

      it 'updates the selected patient' do
        expect { do_request }.to change { patient.address.reload.zip_code }.to zip_code
      end
    end

    context 'with invalid attributes' do
      let(:payload) do
        {
          address: {
            zip_code: ''
          }
        }
      end

      it 'returns http status unprocessable entity' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an object containing the model errors' do
        do_request

        expect(json[:errors][:zip_code].first).to eq("can't be blank")
      end

      it "does not update the patient's name" do
        expect { do_request }.not_to(change { patient.address.reload.zip_code })
      end
    end
  end
end
