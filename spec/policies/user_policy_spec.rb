# frozen_string_literal: true

require 'rails_helper'

describe UserPolicy do
  let(:user_policy) { described_class }

  let(:record) { create(:user) }

  permissions :create? do
    context 'when user is not admin' do
      let(:current_user) { create(:user) }

      it 'denies access' do
        expect(user_policy).not_to permit(current_user, record)
      end
    end

    context 'when user is an admin' do
      let(:current_user) { create(:user, :admin) }

      it 'grants access' do
        expect(user_policy).to permit(current_user, record)
      end
    end
  end

  permissions :update?, :destroy? do
    context 'when user is not admin' do
      context 'when current user is different from user' do
        let(:current_user) { create(:user) }

        it 'denies access' do
          expect(user_policy).not_to permit(current_user, record)
        end
      end

      context 'when current user is the same as user' do
        let(:current_user) { record }

        it 'grants access' do
          expect(user_policy).to permit(current_user, record)
        end
      end
    end

    context 'when user is an admin' do
      let(:current_user) { create(:user, :admin) }

      it 'grants access' do
        expect(user_policy).to permit(current_user, record)
      end
    end
  end
end
