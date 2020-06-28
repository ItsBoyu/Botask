# frozen_string_literal: true

module TasksHelper
  def search_enums(col)
    init_selected = [t("task.#{col}"), '']
    collection = enums(col).keys.map { |key| [t_enum(col, key), enums(col)[key]] }
    collection.unshift(init_selected)
  end

  def form_enums(col)
    enums(col).keys.map { |key| [t_enum(col, key), key] }
  end

  def t_enum(col, key)
    I18n.t("task.#{col.pluralize}.#{key}")
  end

  private

  def enums(col)
    Task.send(col.pluralize)
  end
end
