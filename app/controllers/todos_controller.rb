class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    @todos = Todo.all

    render json: @todos
  end

  def show
    render json: @todo
  end

  def create
    @todo = Todo.create!(params_todo)

    render json: @todo, status: :created
  end

  def update
    @todo.update(params_todo)

    head :no_content
  end

  def destroy
    @todo = Todo.destroy(params[:id])

    head :no_content
  end

  private

  def params_todo
    params.permit(:task, :is_done)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end

