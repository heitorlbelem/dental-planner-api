# frozen_string_literal: true

class Api::Appointments::StatusController < ApplicationController
  before_action :set_appointment

  def confirm
    head :no_content if @appointment.confirm!

    render json: @appointment.errors, status: :unprocessable_entity
  end

  def cancel
    head :no_content if @appointment.cancel!

    render json: @appointment.errors, status: :unprocessable_entity
  end

  def finish
    head :no_content if @appointment.finish!

    render json: @appointment.errors, status: :unprocessable_entity
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
