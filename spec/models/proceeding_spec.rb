# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Proceeding do
  describe 'associations' do
    it { is_expected.to belong_to(:appointment).optional }
    it { is_expected.to belong_to(:patient) }
    it { is_expected.to belong_to(:treatment).optional }
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:price) }
  end
end
