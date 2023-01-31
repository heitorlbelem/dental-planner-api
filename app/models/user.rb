# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  validates :first_name, :last_name, :email, :password, presence: true
  validates :username, uniqueness: true

  before_validation :generate_username, on: :create

  devise :database_authenticatable, :jwt_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :lockable, :confirmable,
    jwt_revocation_strategy: JwtDenylist

  def generate_username
    return if username.present?

    self.username = "#{first_name.parameterize}_#{SecureRandom.hex(4)}"
    while User.exists?(username: username)
      self.username = "#{first_name.parameterize}_#{SecureRandom.hex(4)}"
    end
  end

  def full_name = "#{first_name} #{last_name}"
end
