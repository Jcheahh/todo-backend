class AddTodoGroupToTodos < ActiveRecord::Migration[6.1]
  def change
    add_reference :todos, :todo_group, null: false, foreign_key: true
  end
end
