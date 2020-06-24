class Task < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2 }
end
