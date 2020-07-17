# frozen_string_literal: true

class TaskTag < ApplicationRecord
  belongs_to :task
  belongs_to :tag
end
