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

  def start_date
    params[:start_date]
  end

  def end_date
    params[:end_date]
  end

  def filtered_events
    Event
      .filter_by_doctor_id(doctor_id)
      .filter_by_date_range(start_date, end_date)
  end
end
