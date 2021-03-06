class Todo < ApplicationRecord
  belongs_to :todo_group

  validates_presence_of :task
  validates :is_done, inclusion: { in: [true, false] }
end
