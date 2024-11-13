# frozen_string_literal: true

class Api::Patients::AddressesController < ApplicationController
  before_action :set_patient
  before_action :set_address, only: :show

  def show
    render :show
  end

  def create
    address, success = @patient.replace_address(address_params)
    return head :created if success

    render json: address.errors, status: :unprocessable_entity
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def set_address
    @address = @patient.address
  end

  def address_params
    params.permit(%i[zip_code street number complement neighborhood state city])
  end
end
