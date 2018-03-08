class ChatsController < ApplicationController
  before_action :authenticate_user!

  def new
    @chat = Chat.new
  end

  def create
    @chat = current_user.chats.create
    redirect_to chat_path(@chat)
  end

  def show
    @chat = Chat.find_by_id(params[:id])
  end

  private

  def chat_params
    params.require(:chat)
  end

end
