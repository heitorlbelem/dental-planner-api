# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Doctor do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:expertise) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end
end
