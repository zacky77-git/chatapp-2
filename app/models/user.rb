class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages

  has_many :private_room_users
  has_many :private_rooms, through: :room_users
  has_many :private_messages

  mount_uploader :image, ImageUploader
end
