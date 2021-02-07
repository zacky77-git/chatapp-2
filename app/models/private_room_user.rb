class PrivateRoomUser < ApplicationRecord
  belongs_to :private_room
  belongs_to :user
end
