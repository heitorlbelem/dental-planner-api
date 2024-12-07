# frozen_string_literal: true

class Api::DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[show update destroy]

  def index
    @doctors = filtered_doctors
    @total_count = @doctors.count
    @doctors = @doctors.page(page).per(per_page)
    render :index
  end

  def show
    render :show
  end

  def create
    @doctor = Doctor.new(doctor_params)
    return head :created if @doctor.save

    render json: @doctor.errors, status: :unprocessable_entity
  end

  def update
    if @doctor.update(doctor_params)
      render :show
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  def destroy
    head :no_content if @doctor.destroy
  end

  private

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.permit(%i[name expertise])
  end

  def page
    params[:page_index] || 1
  end

  def per_page
    params[:per_page] || 10
  end

  def filtered_doctors
    doctors = Doctor.all
    doctors = doctors.filter_by_name(params[:name].to_s) if params[:name].present?
    doctors.order(name: :asc)
  end
end
