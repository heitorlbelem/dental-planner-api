# frozen_string_literal: true

require 'rails_helper'

describe ApplicationPolicy do
  let(:app_policy) { described_class }
  let(:current_user) { create(:user) }

  permissions :index?, :create?, :destroy?, :show?, :update? do
    it { expect(app_policy).to permit(current_user) }
  end
end
