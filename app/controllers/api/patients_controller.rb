# frozen_string_literal: true

class Api::PatientsController < ApplicationController
  before_action :set_patient, only: %i[show update destroy]

  def index
    @patients = Patient.all
  end

  def create
    @patient = Patient.new(create_params)
    return head :created if @patient.save

    render :errors, status: :unprocessable_entity
  end

  def update
    if @patient.update(update_params)
      render :show, status: :ok
    else
      render :errors, status: :unprocessable_entity
    end
  end

  def destroy
    return head :no_content if @patient.destroy

    render :errors, status: :unprocessable_entity
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def create_params
    params.require(:patient).permit(%i[
      name email phone birthdate cpf
    ])
  end

  def update_params
    params.require(:patient).permit(%i[
      name email phone birthdate cpf
    ])
  end
end
