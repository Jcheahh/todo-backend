class TodosController < ApplicationController
  before_action :todo_id, only: [:show, :update, :destroy]

  def index
    @todos = Todo.all

    render json: @todos
  end

  def show
    render json: @todo
  end

  def create
    @todo = Todo.create!(params_todo)

    render json: @todo
  end

  def update
    @todo = Todo.update(params_todo)

    head :no_content
  end

  def destroy
    @todo = Todo.destroy

    head :no_content
  end

  private
    def params_todo
      params.require(:todo).permit(:task, :is_done)
    end

    def todo_id
      @todo = Todo.find(params[:id])
    end
end
