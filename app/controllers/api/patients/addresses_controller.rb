# frozen_string_literal: true

class Api::Patients::AddressesController < ApplicationController
  before_action :set_patient

  def create
    @address = @patient.build_address(create_params)
    return head :created if @address.save

    render :errors, status: :unprocessable_entity
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def create_params
    params.require(:address).permit(%i[
      zip_code full_name complement district state city
    ])
  end
end
