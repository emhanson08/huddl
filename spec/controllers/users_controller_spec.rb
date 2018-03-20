require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'users#show' do
    it 'shows the user\'s profile successfully' do
      user = FactoryBot.create(:user)
      sign_in user
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end

    it 'redirects to the user sign-in page if the user isn\'t logged in' do
      user = FactoryBot.create(:user)
      get :show, params: { id: user.id }
      expect(response).to redirect_to new_user_session_path
    end
  end

end
