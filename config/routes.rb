# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'

  defaults format: :json do
    namespace :api do
      resources :patients do
        scope module: :patients do
          resource :address, only: %i[create show]
        end
      end

      resources :doctors, except: :destroy
      resources :appointments, only: %i[create] do
        member do
          scope module: 'appointments' do
            patch :confirm, controller: 'statuses'
            patch :cancel, controller: 'statuses'
            patch :finish, controller: 'statuses'
          end
        end
      end
    end
  end
end
