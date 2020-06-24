require 'rails_helper'

RSpec.describe 'Task', type: :model, driver: :selenium_chrome, js: true do
  describe 'Model validate' do
    let!(:task) { Task.create }

    context 'Fill in every columns' do
      before do
        task.title = '完整填寫'
        task.content = '完整填寫'
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
    end

  end
end
