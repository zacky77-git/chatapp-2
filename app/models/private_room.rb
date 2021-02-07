class PrivateRoom < ApplicationRecord
  # roomを削除したときに、そのroomに関連する情報も削除されるように設定
  has_many :private_room_users, dependent: :destroy
  has_many :users, through: :private_room_users
  # roomを削除したときに、そのroomに関連する情報も削除されるように設定
  has_many :private_messages, dependent: :destroy
end
