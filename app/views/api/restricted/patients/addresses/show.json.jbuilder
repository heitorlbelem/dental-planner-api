# frozen_string_literal: true

json.address do
  json.partial! 'address', locals: { address: @address }
end
