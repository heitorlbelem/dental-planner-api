# frozen_string_literal: true

class Event::Appointment < Event
  include AppointmentStatusChanges

  belongs_to :patient

  validate :doctor_availability, on: %i[create update]

  private

  # TODO: Regra de negócio fica aqui por enquanto
  def doctor_availability
    return unless overlapping_event?

    errors.add(:base, 'this time period is not available for this doctor')
  end

  # TODO: Regra de negócio fica aqui por enquanto
  def overlapping_event?
    Event
      .where(doctor_id:)
      .where.not(id:)
      .where.not(status: %i[canceled completed])
      .where(
        '(start_time, end_time) OVERLAPS (?, ?)',
        start_time, end_time
      ).any?
  end
end
