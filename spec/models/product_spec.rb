# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:default_price) }
  end
end
