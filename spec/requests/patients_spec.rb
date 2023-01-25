# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Patients' do
  describe 'GET /patients' do
    let(:do_request) { get api_patients_path(format: :json) }

    before { create_list(:patient, 4) }

    it 'returns http status Ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns an array containing all the patients' do
      expect(json[:patients].count).to eq(Patient.count)
    end
  end
end
