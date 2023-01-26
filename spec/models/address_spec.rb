# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:zip_code) }
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:neighborhood) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:city) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:patient) }
  end
end
