# frozen_string_literal: true

module Admin::UsersHelper
  def authority(user)
    user.is_admin? ? t('admin') : t('member')
  end
end
