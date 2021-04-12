class RemoveUserFromTodos < ActiveRecord::Migration[6.1]
  def change
    remove_reference :todos, :user, null: false, foreign_key: true
  end
end
