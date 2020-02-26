# frozen_string_literal: true

class User < ApplicationRecord
  before_save do
    name.downcase!
    email.downcase! unless email.blank?
  end
  validates(:name,
            presence: true,
            length: { maximum: 50 },
            uniqueness: {case_sensitive: false})

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            case_sensitive: false,
            allow_blank: true

  validates :password,
            presence: true,
            length: { minimum: 6 }

  has_secure_password

  # Returns the hash digest of the given string.
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ?
               BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
