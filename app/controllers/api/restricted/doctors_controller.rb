# frozen_string_literal: true

class Api::Restricted::DoctorsController < Api::RestrictedController
  before_action :set_doctor, only: %i[show update destroy]

  def index
    render json: Doctor.all, each_serializer: DoctorSerializer, include: [:user]
  end

  def show
    render json: @doctor, include: [:user]
  end

  def create
    @doctor = Doctor.new(create_doctor_params)
    return head :created if @doctor.save

    render_errors @doctor, status: :unprocessable_entity
  end

  def update
    if @doctor.update(update_doctor_params)
      render json: @doctor, include: [:user]
    else
      render_errors @doctor, status: :unprocessable_entity
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def create_doctor_params
    permit_params(only: %i[expertise user_id])
  end

  def update_doctor_params
    permit_params(only: %i[expertise])
  end
end
