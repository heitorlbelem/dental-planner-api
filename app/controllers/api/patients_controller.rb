# frozen_string_literal: true

class Api::PatientsController < ApplicationController
  def index
    @patients = Patient.all
  end
end
