class MessagesController < ApplicationController
    before_action :set_room, only: [:create]
    before_action :set_message, only: [:edit, :update, :destroy]

  def create
    if Entry.where(user_id: current_user.id, room_id: @room.id)
      # ↓ここでエラー　保存できない？
      @message = Message.create(message_params)
      redirect_to room_path(@message)
    else
      flash[:alert] = "メッセージの送信に失敗しました"
    end
  end

  private

  def set_room
    @room = Room.find(params[:message][:room_id])
  end

  # def gets_entries_all_messages
  #   @messages = @room.messages
  #   @entries = @room.entries
  # end

  def message_params
    params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id)
  end

end