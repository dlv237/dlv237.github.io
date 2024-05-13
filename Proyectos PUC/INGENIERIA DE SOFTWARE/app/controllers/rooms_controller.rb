class RoomsController < ApplicationController
    before_action :authenticate_usuario!

    def index
        @rooms = Room.where( usuario_2: current_usuario).or(Room.where(usuario_1: current_usuario))
    end

    def show
        @single_room = Room.find(params[:id])

      @room = Room.new
      @rooms = Room.public_rooms

      @message = Message.new
      @messages = @single_room.messages.order(created_at: :asc)

      render 'index'
    end

    def create
        @room = Room.new(rooms_params)

      if @room.save
          redirect_to rooms_url

      else
          render :new, status: :unprocessable_entity
      end
    end

  private
    def rooms_params
        params.require(:room).permit(:name, :usuario_1, :usuario_2)
    end

end
