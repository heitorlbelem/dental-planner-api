# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  enum :status, {
    pending: 'pending',
    running: 'running',
    done: 'done',
    canceled: 'canceled'
  }, default: 'pending'
end
