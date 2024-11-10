# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Appointments::Statuses' do
  describe 'PATCH /api/appointments/:id/confirm' do
    let(:do_request) do
      patch confirm_api_appointment_path(id),
        headers:,
        as: :json
    end

    context 'when appointment can be confirmed' do
      let(:appointment) { create(:appointment) }
      let(:id) { appointment.id }

      it 'changes the appointment status correctly', :aggregate_failures do
        do_request
        expect(response).to have_http_status(:no_content)
        expect(appointment.reload).to be_confirmed
      end
    end

    context 'when appointment can not be confirmed' do
      let(:appointment) { create(:appointment) }
      let(:id) { appointment.id }

      before { appointment.cancel! }

      it 'changes the appointment status correctly', :aggregate_failures do
        do_request
        expect(response).to have_http_status(:unprocessable_entity)
        expect(appointment.reload).not_to be_confirmed
      end
    end
  end
end
