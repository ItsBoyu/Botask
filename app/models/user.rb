# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks

  validates :email, presence: true,
                    uniqueness: true

  validates :password, presence: true, 
                       confirmation: true, 
                       length: { minimum: 6 }

  validates :password_confirmation, presence: true
  validates :name, presence: true
end
