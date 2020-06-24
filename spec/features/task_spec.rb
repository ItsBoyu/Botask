require 'rails_helper'

RSpec.feature 'Tasks', type: :feature, driver: :selenium_chrome, js: true do
  let!(:task) { Task.create }

  describe 'Basic CRUD' do
    context 'Task Create' do
      before do
        visit root_path
        click_link I18n.t('add')
        fill_in 'task_title', with: '新增任務名稱'
        fill_in 'task_content', with: '新增任務內容'
        click_button I18n.t('task.submit', action: I18n.t('Create'))
      end
      
      it 'User creates a new task' do
        expect(current_url) == root_path
        expect(page).to have_text(I18n.t('task.created'))
        expect(page).to have_text('新增任務名稱')
        expect(page).to have_text('新增任務內容')
      end
    end

    context 'Task Read' do
      before do
        visit root_path
        click_link "/tasks/#{task.id}"
      end

      it 'User views the task' do
        expect(page).to have_text("#{task.title}")
        expect(page).to have_text("#{task.content}")
      end
    end

    context 'Task Update' do
      before do
        visit root_path
        click_link I18n.t('edit'), { href: "/tasks/#{task.id}/edit" }
        fill_in 'task_title', with: '修改任務名稱'
        fill_in 'task_content', with: '修改任務內容'
        click_button I18n.t('task.submit', action: I18n.t('Update'))
      end
      
      it 'User updates the task' do
        expect(current_url) == root_path
        expect(page).to have_text(I18n.t('task.updated'))
        expect(page).to have_text('修改任務名稱')
        expect(page).to have_text('修改任務內容')
      end
    end

    context 'Task Destroy' do
      before do
        visit root_path
        click_link I18n.t('delete'), { href: "/tasks/#{task.id}" }
      end
      
      it 'User deletes the task' do
        expect(page).to have_text(I18n.t('task.deleted'))
        expect(Task.find_by(id: "#{task.id}")).to be nil
      end
    end
  end

  describe 'Tasks sort' do
    context 'Order by created time' do
      before do
        Task.create(title: 'old')
        Timecop.travel(Date.today + 5)
        Task.create(title: 'new')
        Timecop.return
        visit root_path
      end

      it 'new one is on the top' do
        within 'div.task:nth-child(1)' do
          expect(page).to have_text('new')
        end
        within 'div.task:nth-child(2)' do
          expect(page).to have_text('old')
        end
      end
    end
  end
end
