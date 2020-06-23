require 'rails_helper'

RSpec.feature 'Tasks', type: :feature, driver: :selenium_chrome, js: true do
  let!(:task) { Task.create }

  context 'Task Create' do
    scenario 'User creates a new task' do
      visit root_path
      click_link I18n.t('add')
      fill_in 'task_title', with: '新增任務名稱'
      fill_in 'task_content', with: '新增任務內容'
      click_button I18n.t('task.submit', action: I18n.t('Create'))

      expect(current_url) == root_path
      expect(page).to have_text(I18n.t('task.created'))
      expect(page).to have_text('新增任務名稱')
      expect(page).to have_text('新增任務內容')
    end
  end

  context 'Task Read' do
    scenario 'User views the task' do
      visit root_path
      click_link "/tasks/#{task.id}"

      expect(page).to have_text("#{task.title}")
      expect(page).to have_text("#{task.content}")
    end
  end

  context 'Task Update' do
    scenario 'User updates the task' do
      visit root_path
      click_link I18n.t('edit'), { href: "/tasks/#{task.id}/edit" }
      fill_in 'task_title', with: '修改任務名稱'
      fill_in 'task_content', with: '修改任務內容'
      click_button I18n.t('task.submit', action: I18n.t('Update'))

      expect(current_url) == root_path
      expect(page).to have_text(I18n.t('task.updated'))
      expect(page).to have_text('修改任務名稱')
      expect(page).to have_text('修改任務內容')
    end
  end

  context 'Task Destroy' do
    scenario 'User deletes the task' do
      visit root_path
      click_link I18n.t('delete'), { href: "/tasks/#{task.id}" }

      expect(page).to have_text(I18n.t('task.deleted'))
      expect(Task.find_by(id: "#{task.id}")).to be nil
    end
  end
end
