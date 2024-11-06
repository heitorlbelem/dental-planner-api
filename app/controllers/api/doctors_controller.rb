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
    @doctor = Doctor.new(create_doctor_params)
    return head :created if @doctor.save

    render json: @doctor.errors, status: :unprocessable_entity
  end

  def update
    if @doctor.update(update_doctor_params)
      render json: @doctor, include: [:user]
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def create_doctor_params
    params.permit(%i[expertise user_id])
  end

  def update_doctor_params
    params.permit(%i[expertise])
  end
end
