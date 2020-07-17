# frozen_string_literal: true

class Task < ApplicationRecord
  enum status: %i[pending progress done]
  enum priority: %i[low medium high]

  has_many :task_tags
  has_many :tags, through: :task_tags, dependent: :destroy
  belongs_to :user

  validate  :start_before_end
  validates :title, :start_at, :end_at, :status, presence: true
  validates :title, length: { minimum: 2 }

  scope :in_sort, ->(sort_by) { order(sort_by || 'created_at desc') }

  def tag_list=(names)
    self.tags = names.split(',').map do |tag|
      Tag.where(name: tag.strip).first_or_create!
    end
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  private

  def start_before_end
    return if start_at.nil? || end_at.nil?

    errors.add(:end_at, :should_start_before_end) if end_at < start_at
  end
end
