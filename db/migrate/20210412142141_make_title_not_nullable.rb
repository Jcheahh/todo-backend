class MakeTitleNotNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :todo_groups, :title, false
  end
end
