# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Patients' do
  let(:headers) { { accept: 'application/json' } }

  describe 'GET /api/patients' do
    let(:do_request) { get api_patients_path }

    before { create_list(:patient, 4) }

    it 'returns http status Ok' do
      do_request

      expect(response).to have_http_status(:ok)
    end

    it 'returns an array containing all the patients' do
      do_request

      expect(json[:patients].count).to eq(Patient.count)
    end
  end

  describe 'POST /api/patients' do
    let(:do_request) do
      post api_patients_path,
        params: payload,
        headers: headers
    end

    context 'with correct params' do
      let(:expected_patient) { build(:patient) }
      let(:payload) do
        {
          patient: {
            name: expected_patient.name,
            cpf: expected_patient.cpf,
            email: expected_patient.email,
            phone: expected_patient.phone,
            birthdate: expected_patient.birthdate
          }
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:created)
      end

      it 'creates a new patient' do
        expect { do_request }.to change(Patient, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:expected_patient) { build(:patient, cpf: '00000000000', email: '') }
      let(:payload) do
        {
          patient: {
            name: expected_patient.name,
            cpf: expected_patient.cpf,
            email: expected_patient.email,
            phone: expected_patient.phone,
            birthdate: expected_patient.birthdate
          }
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an json object containing the model errors', :aggregate_failures do
        do_request

        expect(json[:errors][:cpf].first).to eq("isn't valid")
        expect(json[:errors][:email].first).to eq("can't be blank")
      end

      it 'does not create a new patient' do
        expect { do_request }.not_to change(Patient, :count)
      end
    end
  end

  describe 'GET /api/patients/:id' do
    before { create_list(:patient, 4) }

    let(:do_request) { get api_patient_path(id) }
    let(:patient) { Patient.first }
    let(:id) { patient.id }
    let(:expected_patient) do
      {
        name: patient.name,
        birthdate: patient.birthdate,
        cpf: patient.cpf,
        phone: patient.phone,
        email: patient.email
      }
    end

    context 'with valid id' do
      it 'returns http status OK' do
        do_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns a the searched patient with expected attributes' do
        do_request

        expect(json[:patient]).to eq(expected_patient)
      end
    end

    context 'with invalid id' do
      let(:id) { 0 }

      it 'returns http status not found' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT /api/patients/:id' do
    let(:do_request) do
      put api_patient_path(id),
        params: payload,
        headers: headers
    end
    let(:patient) { create(:patient) }
    let(:id) { patient.id }

    before { patient }

    context 'with valid params' do
      let(:name) { 'Teste da Silva' }
      let(:payload) do
        {
          patient: {
            name: name
          }
        }
      end

      it 'returns http status code OK' do
        do_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated object' do
        do_request

        expect(json[:patient][:name]).to eq(name)
      end

      it 'updates the selected patient' do
        expect { do_request }.to change { patient.reload.name }.to name
      end
    end

    context 'with invalid params' do
      let(:name) { '' }
      let(:payload) do
        {
          patient: {
            name: name
          }
        }
      end

      it 'returns http status code unprocessable entity' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an object containing the model errors' do
        do_request

        expect(json[:errors][:name].first).to eq("can't be blank")
      end

      it "does not update the patient's name" do
        expect { do_request }.not_to(change { patient.reload.name })
      end
    end

    context 'with invalid id' do
      let(:id) { 0 }
      let(:name) { 'Teste da Silva' }
      let(:payload) do
        {
          patient: {
            name: name
          }
        }
      end

      it 'returns http status not found' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE /api/patients/:id' do
    before { create_list(:patient, 4) }

    let(:do_request) { delete api_patient_path(id) }
    let(:patient) { Patient.last }

    context 'with valid id' do
      let(:id) { patient.id }

      it 'returns http status no content' do
        do_request

        expect(response).to have_http_status(:no_content)
      end

      it 'deletes the patient' do
        expect { do_request }.to change(Patient, :count).by(-1)
      end
    end

    context 'with invalid id' do
      let(:id) { 0 }

      it 'returns http status not found' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
