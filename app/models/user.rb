# frozen_string_literal: true

class User < ApplicationRecord
  audited

  enum :role, {
    admin: 'admin',
    member: 'member'
  }, default: 'member'

  has_one :doctor, dependent: :destroy

  validates :role, presence: true

  validates :first_name, :last_name, :email, presence: true
  validates :username, uniqueness: true,
    format: { with: /\A[a-zA-Z0-9_.\- ]*\z/, multiline: false }

  before_create :generate_username
  before_create :generate_password

  attr_writer :login

  def login
    @login || username || email
  end

  def generate_username
    return if username.present?

    self.username = "#{first_name.parameterize}_#{SecureRandom.hex(4)}"
    while User.exists?(username:)
      self.username = "#{first_name.parameterize}_#{SecureRandom.hex(4)}"
    end
  end

  def generate_password
    self.encrypted_password = SecureRandom.hex(20)
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
