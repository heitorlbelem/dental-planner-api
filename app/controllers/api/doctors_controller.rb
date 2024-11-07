# frozen_string_literal: true

class Api::DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show update destroy]

  def index
    render json: Doctor.all
  end

  def show
    render json: @doctor
  end

  def create
    @doctor = Doctor.new(doctor_params)
    return head :created if @doctor.save

    render json: @doctor.errors, status: :unprocessable_entity
  end

  def update
    if @doctor.update(doctor_params)
      render json: @doctor
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.permit(%i[name expertise])
  end
end
