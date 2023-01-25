# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :patients, only: %i[index show create]
  end
end
