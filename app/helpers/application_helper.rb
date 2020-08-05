# frozen_string_literal: true

module ApplicationHelper
  def lineless_link_to(label, path, *method)
    link_to label, path, method: method, class: 'text-decoration-none text-dark'
  end
end
