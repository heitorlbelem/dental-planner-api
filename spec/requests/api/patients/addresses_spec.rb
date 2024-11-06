# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Patients::Addresses' do
  let(:patient) { create(:patient) }

  describe 'POST /api/patients/:patient_id/address' do
    let(:do_request) do
      post api_patient_address_path(patient.id),
        params: payload,
        headers: headers,
        as: :json
    end

    context 'with correct params' do
      let(:expected_address) { build(:address, zip_code: zip_code) }
      let(:zip_code) { 'zip_code' }
      let(:payload) do
        {
          zip_code: expected_address.zip_code,
          street: expected_address.street,
          number: expected_address.number,
          complment: expected_address.complement,
          neighborhood: expected_address.neighborhood,
          state: expected_address.state,
          city: expected_address.city
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:created)
      end

      it "creates the patient's address" do
        do_request

        expect(patient.reload.address).to be_present
      end

      context 'when the patient already has an address' do
        before { create(:address, patient: patient) }

        it 'deletes the existing address before creating a new one' do
          expect { do_request }.not_to change(Address, :count)
        end

        it 'replaces the existing address', :aggregate_failures do
          old_zip_code = patient.address.zip_code
          do_request

          expect(patient.reload.address.zip_code).not_to eq(old_zip_code)
          expect(patient.reload.address.zip_code).to eq(zip_code)
        end
      end
    end

    context 'with invalid params' do
      let(:invalid_address) { build(:address, zip_code: '') }
      let(:payload) do
        {
          zip_code: invalid_address.zip_code,
          street: invalid_address.street,
          number: invalid_address.number,
          complment: invalid_address.complement,
          neighborhood: invalid_address.neighborhood,
          state: invalid_address.state,
          city: invalid_address.city
        }
      end

      it 'returns http status code unprocessable_entity' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error object with the model error messages', :aggregate_failures do
        do_request

        expect(json.keys).to include(:zip_code)
        expect(json[:zip_code]).to include("can't be blank")
      end

      it 'does not create a new address' do
        expect { do_request }.not_to change(Address, :count)
      end

      it "does not create the patient's address" do
        do_request

        expect(patient.reload.address).to be_nil
      end

      context 'when the patient already has an address' do
        before { create(:address, patient: patient) }

        it 'does not replace the existing address', :aggregate_failures do
          old_zip_code = patient.address.zip_code
          do_request

          expect(patient.reload.address.zip_code).to eq(old_zip_code)
        end
      end
    end
  end

  describe 'GET /api/patients/:patient_id/address' do
    let(:do_request) { get api_patient_address_path(patient.id) }
    let(:address) { create(:address, patient_id: patient.id) }
    let(:expected_address) do
      {
        id: address.id,
        patient_id: address.patient_id,
        zip_code: address.zip_code,
        street: address.street,
        number: address.number,
        neighborhood: address.neighborhood,
        state: address.state,
        city: address.city,
        complement: address.complement,
        created_at: address.created_at.iso8601(3),
        updated_at: address.updated_at.iso8601(3)
      }
    end

    before { address }

    it 'returns http status OK' do
      do_request

      expect(response).to have_http_status(:ok)
    end

    it 'returns the patient address with expected attributes' do
      do_request

      expect(json).to eq(expected_address)
    end
  end
end
