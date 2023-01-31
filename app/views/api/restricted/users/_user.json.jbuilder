# frozen_string_literal: true

json.extract! user, :email, :username, :created_at, :updated_at

json.full_name user.full_name
