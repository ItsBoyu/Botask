# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :find_task, only: %i[show edit update destroy]
  before_action :build_task, only: %i[new create]

  def index
    @q = Task.ransack(params[:q])
    @tasks = @q.result.in_sort(params[:sort_by]).includes(:user).page(params[:page]).per(10)
  end

  def new; end

  def create
    @task.assign_attributes(task_params)

    if @task.save
      redirect_to tasks_path, notice: t('task.created')
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('task.updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('task.deleted')
  end

  private

  def task_params
    params.require(:task).permit(:title,
                                 :content,
                                 :start_at,
                                 :end_at,
                                 :status,
                                 :priority)
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def build_task
    @task = Task.new
  end
end
