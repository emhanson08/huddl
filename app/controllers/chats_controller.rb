class ChatsController < ApplicationController
  before_action :authenticate_user!

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

  private

  def chat_params
    params.require(:chat)
  end

end
