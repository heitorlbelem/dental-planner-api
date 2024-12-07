# frozen_string_literal: true

class Api::PatientsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  def index
    @patients = filtered_patients
    @total_count = @patients.count
    @patients = @patients.page(page).per(per_page)
    render :index
  end

  def show
    render :show
  end

  def create
    @patient = Patient.new(patient_params)
    return head :created if @patient.save

    render json: @patient.errors, status: :unprocessable_entity
  end

  def update
    if @patient.update(patient_params)
      render :show
    else
      render json: @patient.errors, status: :unprocessable_entity
    end
  end

  def destroy
    head :no_content if @patient.destroy
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(%i[name email phone date_of_birth cpf gender])
  end

  def page
    params[:page_index] || 1
  end

  def per_page
    params[:per_page] || 10
  end

  def filtered_patients
    patients = Patient.all
    patients = patients.filter_by_name(params[:name].to_s) if params[:name].present?
    patients.order(name: :asc)
  end
end
