# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Events::Appointments::Statuses' do
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

    context "when appointment can't be confirmed" do
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

  describe 'PATCH /api/appointments/:id/cancel' do
    let(:do_request) do
      patch cancel_api_appointment_path(id),
        headers:,
        as: :json
    end

    context 'when appointment can be canceled' do
      let(:appointment) { create(:appointment) }
      let(:id) { appointment.id }

      it 'changes the appointment status correctly', :aggregate_failures do
        do_request
        expect(response).to have_http_status(:no_content)
        expect(appointment.reload).to be_canceled
      end
    end

    context "when appointment can't be canceled" do
      let(:appointment) { create(:appointment) }
      let(:id) { appointment.id }

      before do
        appointment.confirm!
        appointment.finish!
      end

      it 'changes the appointment status correctly', :aggregate_failures do
        do_request
        expect(response).to have_http_status(:unprocessable_entity)
        expect(appointment.reload).not_to be_canceled
      end
    end
  end

  describe 'PATCH /api/appointments/:id/finish' do
    let(:do_request) do
      patch finish_api_appointment_path(id),
        headers:,
        as: :json
    end

    context 'when appointment can be finished' do
      let(:appointment) { create(:appointment) }
      let(:id) { appointment.id }

      before { appointment.confirm! }

      it 'changes the appointment status correctly', :aggregate_failures do
        do_request
        expect(response).to have_http_status(:no_content)
        expect(appointment.reload).to be_finished
      end
    end

    context "when appointment can't be finished" do
      let(:appointment) { create(:appointment) }
      let(:id) { appointment.id }

      it 'changes the appointment status correctly', :aggregate_failures do
        do_request
        expect(response).to have_http_status(:unprocessable_entity)
        expect(appointment.reload).not_to be_finished
      end
    end
  end
end
