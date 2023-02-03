# frozen_string_literal: true

json.user do
  json.partial! 'user', locals: { user: @user }
end
