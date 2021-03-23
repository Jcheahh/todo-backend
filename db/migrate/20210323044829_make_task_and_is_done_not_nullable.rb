class MakeTaskAndIsDoneNotNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :todos, :task, false
    change_column_null :todos, :is_done, false
  end
end
