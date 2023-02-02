# frozen_string_literal: true

module DeviseHelper
  def login_user(user)
    sign_in user
  end
end
