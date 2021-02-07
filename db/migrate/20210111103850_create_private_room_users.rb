class CreatePrivateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :private_room_users do |t|
      t.references :private_room, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
