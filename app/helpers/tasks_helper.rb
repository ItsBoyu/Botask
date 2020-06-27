# frozen_string_literal: true

module TasksHelper
  def enum_collection(col, act)
    if act == 'db'
      Task.send(col.pluralize).keys.map { |key| [t_enum(col, key), Task.send(col.pluralize)[key]] }
    else
      Task.send(col.pluralize).keys.map { |key| [t_enum(col, key), key] }
    end
  end

  def t_enum(col, key)
    I18n.t("task.#{col.pluralize}.#{key}")
  end
end
