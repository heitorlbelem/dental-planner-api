# frozen_string_literal: true

class Treatment < ApplicationRecord
  belongs_to :patient

  enum :status, {
    pending: 'pending',
    running: 'running',
    done: 'done',
    expired: 'expired'
  }, default: 'pending'
end
