# frozen_string_literal: true

class Api::EventsController < ApplicationController
  def index
    @events = filtered_events
  end

  def destroy
    @event = Event.find(params[:id])
    head :no_content if @event.destroy
  end

  private

  def doctor_id
    params[:doctor_id]
  end

  def filtered_events
    Event.filter_by_doctor_id(doctor_id)
  end
end
