# frozen_string_literal: true

class Api::Appointments::StatusesController < ApplicationController
  before_action :set_appointment

  rescue_from AASM::InvalidTransition, with: :invalid_status_transition

  def confirm
    return head :no_content if @appointment.confirm!
  end

  def cancel
    return head :no_content if @appointment.cancel!
  end

  def finish
    return head :no_content if @appointment.finish!
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def invalid_status_transition
    render json: @appointment.errors, status: :unprocessable_entity
  end
end
