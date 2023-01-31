# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    namespace :api do
      # TO-DO: Analyze this helper and see what to do
      devise_for :users,
        controllers: {
          sessions: 'api/users/sessions'
        }
      scope module: :restricted do
        resources :patients do
          scope module: :patients do
            resource :address, only: %i[create show]
          end
        end

        resources :users
      end
    end
  end
end
