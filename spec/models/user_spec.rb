# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    subject { build(:user, :with_username) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }

    it { is_expected.to validate_uniqueness_of(:username) }
  end

  describe '#full_name' do
    let(:user) { build(:user) }

    let(:expected_name) { "#{user.first_name} #{user.last_name}" }

    it { expect(user.full_name).to eq(expected_name) }
  end

  describe '#generate_username' do
    context 'when username is informed' do
      let(:username) { 'Faker Username' }
      let(:user) { create(:user, username: username) }

      it { expect(user.username).to eq(username) }
    end

    context 'when username is not informed' do
      let(:user) { create(:user, username: nil, first_name: 'test') }
      let(:expected_username) { 'test_4ad737fa' }

      before { allow(SecureRandom).to receive(:hex).and_return('4ad737fa') }

      it { expect(user.username).to eq(expected_username) }
    end

    context 'when tries to generate an existing username' do
      let(:user) { create(:user, username: 'test_4ad737fa') }
      let(:user_two) { create(:user, first_name: 'test') }

      before do
        user
        allow(SecureRandom).to receive(:hex).and_return(
          '4ad737fa', '4ad737fa', '4ad737fb'
        )
      end

      it { expect(user_two.username).to eq('test_4ad737fb') }
    end
  end
end
