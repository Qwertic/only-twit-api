# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates :password, length: { minimum: 8, maximum: 72 }, allow_nil: true
  validates_confirmation_of :password
end
