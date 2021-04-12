class TodoGroupController < ApplicationController
  before_action :set_todo_group, only: [:show, :update, :destroy]

  def show
    @todo_group = current_user.todo_groups.find(params[:id])

    render json: @todo_group
  end

  def create
    @todo_group = current_user.todo_groups.create!(todo_group_params)

    render json: @todo_group, status: :created
  end

  def update
    @todo_group.update(todo_group_params)

    head :no_content
  end

  def destroy
    @todo_group.destroy!

    head :no_content
  end

  private

  def todo_group_params
    params.permit(:title)
  end

  def set_todo_group
    @todo_group = current_user.todo_groups.find(params[:id])
  end
end
