class FriendsController < ApplicationController
  def index
    @friends = User.where.not(id: current_user.id)
  end

  def create
    @friend = User.find([:id])
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end
end
