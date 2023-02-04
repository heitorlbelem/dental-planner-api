# frozen_string_literal: true

class Api::Restricted::Patients::AddressesController < Api::RestrictedController
  before_action :set_patient
  before_action :set_address, only: :show

  def create
    address, success = @patient.replace_address(address_params)
    return head :created if success

    render_errors address, status: :unprocessable_entity
  end

  def show
    render json: @address
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id])
  end

  def set_address
    @address = @patient.address
  end

  def address_params
    permit_params(only: %i[zip_code street number complement neighborhood state city])
  end
end
