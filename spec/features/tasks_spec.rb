# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Tasks', type: :feature, driver: :selenium_chrome, js: true do
  let(:user) { User.create(email: 'rspec@botask.com', password: '123456', name: 'rspec') }
  let!(:task) { user.tasks.create(title: '這是必填', start_at: Time.now, end_at: Time.now + 5.days) }

  before do
    visit root_path
    fill_in 'user_email', with: 'rspec@botask.com'
    fill_in 'user_password', with: '123456'
    click_button I18n.t('user.login')
  end

  describe 'Basic CRUD' do
    context 'Task Create' do
      before do
        visit root_path
        click_link I18n.t('add')
        fill_in 'task_title', with: '新增任務名稱'
        fill_in 'task_content', with: '新增任務內容'
        fill_in 'task_start_at', with: Time.now
        fill_in 'task_end_at', with: Time.now + 5.days
        click_button I18n.t('task.submit', action: I18n.t('Create'))
      end

      it 'User creates a new task' do
        expect(current_url) == root_path
        expect(page).to have_text(I18n.t('task.created'))
        expect(page).to have_text('新增任務名稱')
        expect(page).to have_text('新增任務內容')
        expect(page).to have_text(Time.now.strftime('%m-%d-%Y'))
        expect(page).to have_text((Time.now + 5.days).strftime('%m-%d-%Y'))
      end
    end

    context 'Task Read' do
      before do
        visit root_path
        click_link '這是必填', { href: "/tasks/#{task.id}" }
      end

      it 'User views the task' do
        expect(page).to have_text(task.title)
        expect(page).to have_text(task.content)
        expect(page).to have_text(task.start_at.strftime("%m-%d-%Y %H：%M"))
        expect(page).to have_text(task.end_at.strftime("%m-%d-%Y %H：%M"))
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
    before do
      user.tasks.create(title: 'old', start_at: Time.now, end_at: Time.now + 5.days, priority: 1)
      Timecop.travel(Date.today + 5)
      user.tasks.create(title: 'new', start_at: Time.now, end_at: Time.now + 5.days, priority: 2)
      Timecop.return
      visit root_path
    end
    
    context 'Default order by created time' do
      it 'new one is on the top' do
        within 'div.task:nth-child(1)' do
          expect(page).to have_text('new')
        end
        within 'div.task:nth-child(2)' do
          expect(page).to have_text('old')
        end
      end
    end

    context 'Order by created time' do
      before do
        click_link I18n.t('task.end_at'), { href: "/tasks?sort_by=end_at" }
      end

      it 'old one is on the top' do
        within 'div.task:nth-child(2)' do
          expect(page).to have_text('old')
        end
        within 'div.task:nth-child(3)' do
          expect(page).to have_text('new')
        end
      end
    end

    context 'Order by priority' do
      before do
        click_link I18n.t('task.priority'), { href: "/tasks?sort_by=priority+desc" }
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

  describe 'Tasks search' do
    before do
      visit root_path
    end

    context 'search by title' do
      context 'when a match is found' do
        before do
          fill_in 'q_title_cont', with: '這'
          click_button '搜尋'
        end

        it 'returns tasks that match the search term' do
          expect(page).to have_content '這是必填'
        end
      end

      context 'when no match is found' do
        before do
          fill_in 'q_title_cont', with: '別'
          click_button '搜尋'
        end

        it 'returns an empty collection' do
          expect(page).not_to have_content '這是必填'
        end
      end
    end

    context 'search by stauts' do
      context 'when a match is found' do
        before do
          select('待處理', from: 'q_status_eq').select_option
          click_button '搜尋'
        end

        it 'returns tasks that match the search term' do
          expect(page).to have_content '這是必填'
        end
      end

      context 'when no match is found' do
        before do
          select('已完成', from: 'q_status_eq').select_option
          click_button '搜尋'
        end

        it 'returns an empty collection' do
          expect(page).not_to have_content '這是必填'
        end
      end
    end
  end
end
