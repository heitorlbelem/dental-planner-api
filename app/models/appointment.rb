# frozen_string_literal: true

class Appointment < ApplicationRecord
  include AppointmentStatusChanges

  belongs_to :doctor
  belongs_to :patient

  validates :status, presence: true
  validates :start_time, presence: true
  validates :duration_in_minutes, presence: true
  validate :start_time_in_the_past, on: %i[create update]
  validate :doctor_availability, on: %i[create update]

  private

  def start_time_in_the_past
    return if start_time.blank? || start_time >= Time.current

    errors.add(:start_time, 'Invalid date to schedule the appointment')
  end

  def doctor_availability
    overlapping_appointment = Appointment.where.not(patient_id:)
      .exists?(doctor_id:, start_time:)
    return unless overlapping_appointment

    errors.add(:start_time, 'is not available for this doctor')
  end
end
