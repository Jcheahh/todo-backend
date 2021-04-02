class TodosController < ApplicationController
  before_action :set_todo, only: %i[update destroy]
  before_action :authenticate_user!

  def index
    @todos = current_user.todos

    render json: @todos
  end

  def create
    @todo = current_user.todos.create!(todo_params)

    render json: @todo, status: :created
  end

  def update
    @todo.update(todo_params)

    head :no_content
  end

  def destroy
    @todo = current_user.todos.destroy(params[:id])

    head :no_content
  end

  private

  def todo_params
    params.permit(:task, :is_done)
  end

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end
end
