# frozen_string_literal: true

class Api::AppointmentsController < ApplicationController
  def create
    @appointment = Appointment.new(create_appointment_params)
    return head :created if @appointment.save

    render json: @appointment.errors, status: :unprocessable_entity
  end

  private

  def create_appointment_params
    params.require(:appointment)
      .permit(%i[
        doctor_id patient_id start_time duration_in_minutes
      ])
  end
end
