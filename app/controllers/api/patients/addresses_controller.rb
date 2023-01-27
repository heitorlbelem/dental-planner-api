# frozen_string_literal: true

class Api::Patients::AddressesController < ApplicationController
  before_action :set_patient
  before_action :set_address, except: :create

  def show; end

  def create
    @address, success = @patient.replace_address(address_params)
    return head :created if success

    render_errors @address.errors, status: :unprocessable_entity
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def set_address
    @address = @patient.address
  end

  def address_params
    params.require(:address).permit(%i[
      zip_code street number complement neighborhood state city
    ])
  end
end
