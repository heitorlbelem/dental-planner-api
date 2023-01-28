# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      resources :patients do
        scope module: :patients do
          resource :address, only: %i[create show]
        end
      end
    end
  end
end
