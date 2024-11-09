# frozen_string_literal: true

module AppointmentStatusChanges
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: 'status' do
      state :pending, initial: true
      state :confirmed
      state :canceled
      state :finished

      event :confirm do
        transitions from: :pending, to: :confirmed
      end

      event :cancel do
        transitions from: %i[pending confirmed], to: :canceled
      end

      event :finish do
        transitions from: :confirmed, to: :finished
      end
    end
  end
end
