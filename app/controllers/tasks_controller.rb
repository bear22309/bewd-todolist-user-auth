# File: app/controllers/tasks_controller.rb

class TasksController < ApplicationController
  before_action :authenticate_user!

  # GET /my_tasks
  def index_by_current_user
    @tasks = Task.where(user_id: current_user.id)
    render json: @tasks, status: :ok
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    if @task.save
      render json: @task, status: :created
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/:id
  def destroy
    @task = Task.find_by(id: params[:id], user: current_user)
    if @task
      @task.destroy
      head :no_content
    else
      render json: { error: 'Task not found or you are not authorized' }, status: :not_found
    end
  end

  # PUT /tasks/:id/mark_complete
  def mark_complete
    @task = Task.find_by(id: params[:id], user: current_user)

    if @task&.update(completed: true)
      render json: @task
    else
      render json: { error: 'Task not found or you are not authorized' }, status: :not_found
    end
  end

  # PUT /tasks/:id/mark_active
  def mark_active
    @task = Task.find_by(id: params[:id], user: current_user)

    if @task&.update(completed: false)
      render json: @task
    else
      render json: { error: 'Task not found or you are not authorized' }, status: :not_found
    end
  end

  private

  def task_params
    params.require(:task).permit(:content)
  end
end

