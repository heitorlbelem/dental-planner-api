# frozen_string_literal: true

class Event::Block < Event
  before_create :set_default_status

  private

  def set_default_status
    self.status = :blocked
  end
end
