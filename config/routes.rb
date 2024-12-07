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

      resources :doctors

      resources :events, only: %i[index]
      scope module: 'events' do
        resources :appointments, only: %i[create] do
          member do
            scope module: 'appointments' do
              patch :confirm, controller: 'statuses'
              patch :cancel, controller: 'statuses'
              patch :finish, controller: 'statuses'
            end
          end
        end
        resources :blocks, only: %i[create]
      end
    end
  end
end
