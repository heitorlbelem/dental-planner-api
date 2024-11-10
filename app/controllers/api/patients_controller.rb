# frozen_string_literal: true

class Api::PatientsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  def index
    @patients = Patient.all
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
    return head :no_content if @patient.destroy

    render json: @patient.errors, status: :unprocessable_entity
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.permit(%i[name email phone birthdate cpf])
  end
end
