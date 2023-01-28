# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :lockable, :confirmable,
    jwt_revocation_strategy: JwtDenyList
end
