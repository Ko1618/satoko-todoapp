# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text             not null
#  expiry      :date             not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  board_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
class Task < ApplicationRecord
  belongs_to :user
  belongs_to :board
  has_one_attached :eyecatch

  validates :title, presence: true
  validates :description, presence: true
  validates :expiry, presence: true
end
