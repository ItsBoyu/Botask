class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  before_action :build_task, only: [:new, :create]

  def index
    @tasks = Task.all
  end

  def new; end

  def create
    @task.assign_attributes(task_params)

    if @task.save
      redirect_to tasks_path, notice: '新增任務成功'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: '更新任務成功'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: '刪除任務成功'
  end

  private
  def task_params
    params.require(:task).permit(:title,
                                 :content)
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def build_task
    @task = Task.new
  end

end
