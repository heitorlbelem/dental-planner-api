# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event::Block, type: :model do
  describe 'callbacks' do
    context 'when validating status' do
      it 'set the default value for status' do
        block = create(:block)
        expect(block.status).to eq('blocked')
      end
    end
  end
end
