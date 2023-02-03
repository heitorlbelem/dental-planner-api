# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Restricted' do
  let(:headers) { { accept: 'application/json' } }
  let(:user) { create(:user) }

  before { login user }

  describe '#NotAuthorizedError' do
    let(:do_request) do
      post api_users_path, params: payload, headers: headers
    end
    let(:user) { create(:user) }
    let(:id) { user.id }
    let(:payload) { { user: { first_name: 'Other' } } }

    before { user }

    it 'returns http status code forbidden' do
      do_request

      expect(response).to have_http_status(:forbidden)
    end

    it 'returns an json of errors' do
      do_request

      expect(json).to eq({ errors: 'Unauthorized' })
    end
  end
end
