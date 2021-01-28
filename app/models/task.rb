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
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :expiry, presence: true

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end

  def expiry_date
    self.expiry.strftime('%y/%m/%d')
  end

  def author_name
    user.display_name
  end
end
