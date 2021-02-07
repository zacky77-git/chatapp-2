class RoomsController < ApplicationController
  def index
    @friends = User.where.not(id: current_user.id)

    # @rooms = current_user.rooms.where.not('name == ?', @friends.name)
    @rooms = current_user.rooms
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to room_messages_path(@room)
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to rooms_path
  end

  def friend
    @friends = User.where.not(id: current_user.id)

    @belong_rooms = PrivateRoomUser.where(user_id: current_user.id)
    @rooms = PrivateRoomUser.where(user_id: @friends.ids)
  end

  def chat
    @friend = User.find(params[:id])
    @room = PrivateRoom.new(user_ids: [@friend.id, current_user.id])
    # @room = PrivateRoom.new(chat_room_params)
    if @room.save
      redirect_to root_path
    else
      render :friend
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end

  def chat_room_params
    params.require(:private_room).merge(user_ids: [@friend.id, current_user.id])
    # params.require(:room).permit(:name, user_ids: [])
  end
end
