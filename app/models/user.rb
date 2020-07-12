# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  before_destroy :check_admin_exist

  has_many :tasks, dependent: :destroy

  validates :email, presence: true,
                    uniqueness: true

  validates :name, presence: true

  scope :admin, -> { where(is_admin: true) }

  private

  def check_admin_exist
    return unless is_admin? && User.admin.size <= 1

    errors.add :base, :the_last_admin
    throw :abort
  end
end
