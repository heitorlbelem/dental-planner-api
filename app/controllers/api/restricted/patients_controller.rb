# frozen_string_literal: true

class Api::Restricted::PatientsController < Api::RestrictedController
  before_action :set_patient, only: %i[show update destroy]

  def index
    @patients = Patient.all
  end

  def create
    @patient = Patient.new(patient_params)
    return head :created if @patient.save

    render_errors @patient.errors, status: :unprocessable_entity
  end

  def update
    if @patient.update(patient_params)
      render :show, status: :ok
    else
      render_errors @patient.errors, status: :unprocessable_entity
    end
  end

  def destroy
    return head :no_content if @patient.destroy

    render_errors @patient.errors, status: :unprocessable_entity
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(%i[
      name email phone birthdate cpf
    ])
  end
end
