# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    subject { build(:user, :with_username) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe '#full_name' do
    let(:user) { build(:user) }

    let(:expected_name) { "#{user.first_name} #{user.last_name}" }

    it { expect(user.full_name).to eq(expected_name) }
  end

  describe '#generate_username' do
    context 'when username is informed' do
      let(:username) { 'FakerUsername' }
      let(:user) { create(:user, username: username) }

      it { expect(user.username).to eq(username.downcase) }
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

  describe '#find_for_database_authentication' do
    let(:user) do
      create(:user, username: 'test', email: 'test@test.com', first_name: 'test')
    end

    before { user }

    def do_action(conditions)
      described_class.find_for_database_authentication(conditions)
    end

    context 'when find by login' do
      it 'correct username' do
        expect(do_action({ login: 'test' })).to eq(user)
      end

      it 'correct email' do
        expect(do_action({ login: 'test@test.com' })).to eq(user)
      end

      it 'incorrect data' do
        expect(do_action({ login: 'test_test' })).to be_nil
      end
    end

    context 'when find by username' do
      it 'correct username' do
        expect(do_action({ username: 'test' })).to eq(user)
      end

      it 'incorrect username' do
        expect(do_action({ username: 'test@test.com' })).to be_nil
      end
    end

    context 'when find by email' do
      it 'correct email' do
        expect(do_action({ email: 'test@test.com' })).to eq(user)
      end

      it 'incorrect email' do
        expect(do_action({ email: 'test' })).to be_nil
      end
    end
  end
end
