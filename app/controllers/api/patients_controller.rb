# frozen_string_literal: true

class Api::PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def create
    @patient = Patient.new(create_params)
    return head :created if @patient.save

    render :errors, status: :unprocessable_entity
  end

  def update
    @patient = Patient.find(params[:id])

    if @patient.update(update_params)
      render :show, status: :ok
    else
      render :errors, status: :unprocessable_entity
    end
  end

  private

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
