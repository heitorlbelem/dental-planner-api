# frozen_string_literal: true

class Api::Patients::AddressesController < ApplicationController
  before_action :set_patient

  def show
    @address = @patient.address
  end

  def create
    @address = @patient.build_address(address_params)
    return head :created if @address.save

    render :errors, status: :unprocessable_entity
  end

  def update
    @address = @patient.address

    if @address.update(address_params)
      render :show, status: :ok
    else
      render :errors, status: :unprocessable_entity
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def address_params
    params.require(:address).permit(%i[
      zip_code full_name complement district state city
    ])
  end
end
