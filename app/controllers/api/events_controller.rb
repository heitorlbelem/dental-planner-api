# frozen_string_literal: true

class Api::EventsController < ApplicationController
  def index
    @events = filtered_events
  end

  private

  def doctor_id
    params[:doctor_id]
  end

  def filtered_events
    events = Event.all
    events = events.filter_by_doctor_id(doctor_id) if doctor_id.present?
    events
  end
end
