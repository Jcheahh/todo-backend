class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo_group
  before_action :set_todo, only: [:update, :destroy]

  def index
    @todos = @todo_group.todos

    render json: @todos
  end

  def create
    @todo = @todo_group.todos.create!(todo_params)

    render json: @todo, status: :created
  end

  def update
    @todo.update(todo_params)

    head :no_content
  end

  def destroy
    @todo = @todo_group.todos.destroy(params[:id])

    head :no_content
  end

  private

  def todo_params
    params.permit(:task, :is_done)
  end

  def set_todo_group
    @todo_group = current_user.todo_groups.find(params[:todo_group_id])
  end

  def set_todo
    @todo = @todo_group.todos.find(params[:id])
  end
end
