class Room < ApplicationRecord
  # roomを削除したときに、そのroomに関連する情報も削除されるように設定
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users
  # roomを削除したときに、そのroomに関連する情報も削除されるように設定
  has_many :messages, dependent: :destroy

  validates :name, presence: true
end
