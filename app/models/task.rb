# frozen_string_literal: true

class Task < ApplicationRecord
  validate  :start_before_end
  validates :title, :start_at, :end_at, presence: true
  validates :title, length: { minimum: 2 }

  private

  def start_before_end
    return if start_at.nil? || end_at.nil?
    errors.add(:end_at, :should_start_before_end) if end_at < start_at
  end
end
