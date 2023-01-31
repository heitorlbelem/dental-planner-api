# frozen_string_literal: true

json.users do
  json.array! @users do |user|
    json.partial! 'user', locals: { user: user }
  end
end
