# frozen_string_literal: true

class User < ApplicationRecord
  enum role: {
    admin: 'admin',
    member: 'member'
  }, _default: 'member'
  validates :role, presence: true

  validates :first_name, :last_name, :email, :password, presence: true
  validates :username, uniqueness: true,
    format: { with: /\A[a-zA-Z0-9_.\- ]*\z/, multiline: false }

  before_create :generate_username

  devise :database_authenticatable, :jwt_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :lockable, :confirmable,
    jwt_revocation_strategy: JwtDenylist

  attr_writer :login

  def login
    @login || username || email
  end

  def generate_username
    return if username.present?

    self.username = "#{first_name.parameterize}_#{SecureRandom.hex(4)}"
    while User.exists?(username: username)
      self.username = "#{first_name.parameterize}_#{SecureRandom.hex(4)}"
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['lower(username) = :value OR lower(email) = :value',
                                    { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end
end
