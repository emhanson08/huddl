class ChatsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :update]

  def index
    @chats = Chat.all
  end

  def new
    @chat = Chat.new
  end

  def create
    if current_user
      @chat = current_user.chats.create
      redirect_to chat_path(@chat)
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @chat = Chat.find_by_id(params[:id])
  end

  def update
    @chat = Chat.find_by_id(params[:id])
    array = @chat.chat_log
    array.push(current_user.email + ': ' + chat_params[:chat_log])
    @chat.update(chat_log: array)
    # redirect_to chat_path(@chat)
    if @chat.save
      ActionCable.server.broadcast "main_chat",
                                    chat_log: @chat.chat_log
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:chat_log)
  end

end
