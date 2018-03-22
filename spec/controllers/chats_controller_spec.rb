require 'rails_helper'

RSpec.describe ChatsController, type: :controller do

  describe "chats#index action" do
    it "should render the chats index" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "chats#new action" do
    it "should show the chat form" do
      user = FactoryBot.create(:user)
      sign_in user
      get :new
      expect(response).to have_http_status(:success)
    end

    it "should not allow a new chat if the user isn't signed in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "chats#create action" do
    it "should successfully create a new chat" do
      user = FactoryBot.create(:user)
      sign_in user
      post :create
      chat = Chat.last
      expect(chat.user).to eq(user)
      expect(response).to redirect_to chat_path(chat)
    end

    it "shouldn't allow a chat to be created unless the user is signed in" do
      post :create
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "chats#show action" do
    it "should render the chat if the user is signed in" do
      user = FactoryBot.create(:user)
      sign_in user
      chat = user.chats.create
      get :show, params: {id: chat.id}
      expect(response).to have_http_status(:success)
    end

    it "should redirect_to user sign-in page if the user isn't logged in" do
      user = FactoryBot.create(:user)
      sign_in user
      chat = user.chats.create
      sign_out user
      get :show, params: {id: chat.id}
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe "chats#update action" do
    it "should update the chat log with the submitted text" do
      user = FactoryBot.create(:user)
      sign_in user
      chat = user.chats.create
      patch :update, params: { id: chat.id, chat: { chat_log: 'Hello World' } }
      chat.reload
      expect(chat.chat_log).to eq(['Hello World'])
      expect(response).to redirect_to chat_path(chat)
    end
  end
end