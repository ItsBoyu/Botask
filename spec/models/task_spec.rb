# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task', type: :model, driver: :selenium_chrome, js: true do
  describe 'Model validate' do
    let!(:task) { Task.create }

    context 'Fill in every columns' do
      before do
        task.title = '完整填寫'
        task.content = '完整填寫'
        task.start_at = "#{Time.now}"
        task.end_at = "#{Time.now} + 5.days"
      end

      it 'create successfully' do
        expect(task).to be_valid
      end
    end

    context 'Not fill in every columns' do
      it 'when title is nil' do
        expect(task).not_to be_valid
        expect(task.errors.messages[:title]).to eq ['不能為空白', '過短（最短是 2 個字）']
      end

      it 'when start_at is nil' do
        expect(task).not_to be_valid
        expect(task.errors.messages[:start_at]).to eq ['不能為空白']
      end

      it 'when end_at is nil' do
        expect(task).not_to be_valid
        expect(task.errors.messages[:end_at]).to eq ['不能為空白']
      end
    end
  end
end
