# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Restricted::Users' do
  let(:headers) do
    {
      'Content-Type' => 'application/vnd.api+json',
      'Accept' => 'application/vnd.api+json'
    }
  end
  let(:current_user) { create(:user, :admin) }

  before { login(current_user) }

  describe 'GET /api/users' do
    let(:do_request) { get api_users_path }

    before { create_list(:user, 4) }

    it 'returns http status Ok' do
      do_request

      expect(response).to have_http_status(:ok)
    end

    it 'returns an array containing all the users' do
      do_request

      expect(json[:data].count).to eq(User.count)
    end
  end

  describe 'POST /api/users' do
    let(:do_request) do
      post api_users_path,
        params: payload,
        headers: headers,
        as: :json
    end

    context 'with correct params' do
      let(:expected_user) { build(:user, :with_username) }
      let(:payload) do
        {
          data: {
            type: 'users',
            attributes: {
              first_name: expected_user.first_name,
              last_name: expected_user.last_name,
              email: expected_user.email,
              username: expected_user.username,
              password: expected_user.password
            }
          }
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:created)
      end

      it 'creates a new user' do
        expect { do_request }.to change(User, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:expected_user) { build(:user, email: '') }
      let(:payload) do
        {
          data: {
            type: 'users',
            attributes: {
              first_name: expected_user.first_name,
              last_name: expected_user.last_name,
              email: expected_user.email,
              username: expected_user.username,
              password: expected_user.password
            }
          }
        }
      end

      it 'returns http status code created' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an json object containing the model errors', :aggregate_failures do
        do_request

        expect(json[:errors].first[:source][:pointer]).to include('email')
        expect(json[:errors].first[:detail]).to include("can't be blank")
      end

      it 'does not create a new user' do
        expect { do_request }.not_to change(User, :count)
      end
    end

    context 'when current_user does not have permission to create a new user' do
      let(:current_user) { create(:user) }
      let(:payload) { nil }

      it 'returns http status code forbidden' do
        do_request

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET /api/users/:id' do
    before { create_list(:user, 4) }

    let(:do_request) { get api_user_path(id) }
    let(:user) { User.first }
    let(:id) { user.id }
    let(:expected_user) do
      {
        full_name: "#{user.first_name} #{user.last_name}",
        email: user.email,
        username: user.username,
        role: user.role,
        created_at: user.created_at.iso8601(3),
        updated_at: user.updated_at.iso8601(3)
      }
    end

    context 'with valid id' do
      it 'returns http status OK' do
        do_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns the searched user with expected attributes' do
        do_request

        expect(json[:data][:attributes]).to eq(expected_user)
      end
    end

    context 'with invalid id' do
      let(:id) { 0 }

      it 'returns http status not found' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT /api/users/:id' do
    let(:do_request) do
      put api_user_path(id),
        params: payload,
        headers: headers,
        as: :json
    end
    let(:user) { create(:user) }
    let(:id) { user.id }

    before { user }

    context 'with valid params' do
      let(:first_name) { 'Testando' }
      let(:last_name) { 'da Silva' }
      let(:expected_full_name) { "#{first_name} #{last_name}" }
      let(:payload) do
        {
          data: {
            type: 'users',
            id: id,
            attributes: {
              first_name: first_name,
              last_name: last_name,
              password: user.password
            }
          }
        }
      end

      it 'returns http status code OK' do
        do_request

        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated object' do
        do_request

        expect(json[:data][:attributes][:full_name]).to eq(expected_full_name)
      end

      it 'updates the selected user' do
        expect { do_request }.to change { user.reload.first_name }.to first_name
      end
    end

    context 'with invalid params' do
      let(:first_name) { '' }
      let(:payload) do
        {
          data: {
            type: 'users',
            id: id,
            attributes: {
              first_name: first_name,
              password: user.password
            }
          }
        }
      end

      it 'returns http status code unprocessable entity' do
        do_request

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an object containing the model errors', :aggregate_failures do
        do_request

        expect(json[:errors].first[:source][:pointer]).to include('first_name')
        expect(json[:errors].first[:detail]).to include("can't be blank")
      end

      it "does not update the user's first name" do
        expect { do_request }.not_to(change { user.reload.first_name })
      end
    end

    context 'with invalid id' do
      let(:id) { 0 }
      let(:first_name) { 'Teste' }
      let(:payload) do
        {
          user: {
            first_name: first_name,
            password: user.password
          }
        }
      end

      it 'returns http status not found' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when current_user does not have permission to update user' do
      let(:current_user) { create(:user) }
      let(:payload) { nil }

      it 'returns http status code forbidden' do
        do_request

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE /api/users/:id' do
    let(:user) { create(:user) }
    let(:do_request) { delete api_user_path(id) }

    before { user }

    context 'with valid id' do
      let(:id) { user.id }

      it 'returns http status no content' do
        do_request

        expect(response).to have_http_status(:no_content)
      end

      it 'deletes the user' do
        expect { do_request }.to change(User, :count).by(-1)
      end

      it 'returns error when does not destroy the resource' do
        allow(User).to receive(:find).and_return(user)
        allow(user).to receive(:destroy).and_return(false)
        do_request

        expect(json[:errors]).not_to be_nil
      end
    end

    context 'with invalid id' do
      let(:id) { 'invalid id' }

      it 'returns http status not found' do
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when current_user does not have permission to destroy user' do
      let(:current_user) { create(:user) }
      let(:payload) { nil }
      let(:id) { user.id }

      it 'returns http status code forbidden' do
        do_request

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
