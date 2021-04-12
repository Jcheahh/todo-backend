class TodoGroup < ApplicationRecord
  belongs_to :user

  has_many :todos

  validates_presence_of :title
end
