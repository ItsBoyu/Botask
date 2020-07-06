# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task', type: :model, driver: :selenium_chrome, js: true do
  describe 'Model validate' do
    let(:user) { User.create }
    let!(:task) { user.tasks.new(title: '完整填寫',
                                 content: '完整填寫',
                                 start_at: "#{Time.now}",
                                 end_at: "#{Time.now + 5.days}",
                                ) }

    context 'When pass the validation' do
      it 'is valid to have a title, content, start_at and end_at' do
        expect(task).to be_valid
      end
    end

    context 'When fail the validation' do
      it 'is invalid without a title' do
        task.title = nil

        expect(task).not_to be_valid
        expect(task.errors.messages[:title]).to include '不能為空白'
      end

      it 'is invalid the title short than 2 characters' do
        task.title = '完'

        expect(task).not_to be_valid
        expect(task.errors.messages[:title]).to include '過短（最短是 2 個字）'
      end

      it 'is invalid without a time when start_at' do
        task.start_at = nil

        expect(task).not_to be_valid
        expect(task.errors.messages[:start_at]).to include '不能為空白'
      end

      it 'is invalid without a time when end_at' do
        task.end_at = nil

        expect(task).not_to be_valid
        expect(task.errors.messages[:end_at]).to include '不能為空白'
      end

      it 'is invalid when the time end_at before start_at' do
        task.start_at = "#{Time.now}"
        task.end_at = "#{Time.now - 5.days}"

        expect(task).not_to be_valid
        expect(task.errors.messages[:end_at]).to include '不能早於開始時間'
      end
    end
  end
end
