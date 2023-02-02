# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions' do
  let(:headers) { { accept: 'application/json' } }

  describe 'POST /api/users/sign_in' do
    let(:do_request) do
      post api_user_session_path,
        params: payload,
        headers: headers
    end

    context 'with existent user' do
      before { create(:user, username: 'test', password: 'foobar123') }

      let(:payload) do
        {
          api_user: {
            login: 'test',
            password: 'foobar123'
          }
        }
      end

      it 'signs in the user', :aggregate_failures do
        do_request

        expect(response.headers['Authorization']).not_to be_empty
        expect(response).to have_http_status(:ok)
        expect(json[:message]).to eq('Logged.')
      end
    end

    context 'with inexistent user' do
      before { create(:user, username: 'test', password: 'foobar123') }

      let(:payload) do
        {
          api_user: {
            login: 'test_inexistent',
            password: 'foobar123'
          }
        }
      end

      it 'returns sign in error', :aggregate_failures do
        do_request

        expect(response.headers['Authorization']).to eq(nil)
        expect(response).to have_http_status(:unauthorized)
        expect(json[:error]).to eq('Invalid Login or password.')
      end
    end
  end
end
