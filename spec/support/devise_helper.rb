# frozen_string_literal: true

module DeviseHelper
  def login_user
    sign_in FactoryBot.create(:user, :confirmed)
  end
end
