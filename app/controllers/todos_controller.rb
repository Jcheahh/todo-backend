class TodosController < ApplicationController
  # before_action :set_todo, only: [:update, :destroy]
  before_action :authenticate_user!
  before_action :set_todo_group

  def index
    @todos = current_user.todo_groups.todos

    render json: @todos
  end

  def create
    @todo = current_user.todo_groups.todos.create!(todo_params)

    render json: @todo, status: :created
  end

  def update
    @todo.update(todo_params)

    head :no_content
  end

  def destroy
    @todo = current_user.todo_groups.todos.destroy(params[:id])

    head :no_content
  end

  private

  def todo_params
    params.permit(:task, :is_done)
  end

  # def set_todo
  #   @todo = current_user.todo_groups.todos.find(params[:id])
  # end

  def set_todo_group
    @todo_group = current_user.todo_groups.find(params[:todo_group_id])
  end
end
