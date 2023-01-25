# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      resources :patients do
        resources :addresses, only: %i[create show update], module: :patients
      end
    end
  end
end
