# frozen_string_literal: true

module DeviseHelper
  def login(user)
    sign_in user
  end
end
