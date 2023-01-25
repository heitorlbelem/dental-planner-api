# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Patients' do
  describe 'GET /patients' do
    let(:do_request) { get api_patients_path(format: :json) }

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

  describe 'GET /patients/:id' do
    before { create_list(:patient, 4) }

    let(:do_request) { get api_patient_path(id, format: :json) }
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

    it 'returns http status OK' do
      do_request

      expect(response).to have_http_status(:ok)
    end

    it 'returns a the searched patient with expected attributes' do
      do_request

      expect(json[:patient]).to eq(expected_patient)
    end
  end
end
