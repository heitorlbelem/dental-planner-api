# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :doctor

  validates :start_time, :end_time, presence: true
  validate :start_time_in_the_past, on: %i[create update]

  before_validation :calculate_end_time, if: -> { duration.present? }

  attr_accessor :duration

  private

  # TODO: Regra de negócio fica por enquanto
  def start_time_in_the_past
    return if start_time.blank? || start_time >= Time.current

    errors.add(:start_time, 'invalid date to create an event')
  end

  def calculate_end_time
    return if start_time.blank?
    return self.end_time = start_time + duration.minutes if duration.positive?

    errors.add(:end_time, "can't be before the start_time")
  end
end
