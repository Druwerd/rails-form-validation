require 'rails_helper'

RSpec.describe UserSessionsController, type: :request do
  describe 'GET #new' do
    it 'renders the new template without saved email' do
      get new_user_session_path

      expect(response).to render_template(:new)
      expect(assigns(:user).email).to eq('')
    end

    context 'with email param' do
      it 'renders the new template with saved email' do
        get new_user_session_path params: {email: "test@example.com"}

        expect(response).to render_template(:new)
        expect(assigns(:user).email).to eq('test@example.com')
      end
    end
  end

  describe 'POST #create' do
    let(:valid_user) do
      create(:user,
        email: 'user@example.com',
        password: 'Password123!',
        password_confirmation: 'Password123!'
      )
    end

    context 'with valid credentials' do
      let(:valid_params) do
        {
          user: {
            email: valid_user.email,
            password: 'Password123!'
          }
        }
      end

      it 'logs in successfully' do
        post user_sessions_path, params: valid_params

        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(response.body).to include('Login successful')
      end
    end

    context 'with invalid credentials' do
      let(:invalid_params) do
        {
          user: {
            email: valid_user.email,
            password: 'invalid_password'
          }
        }
      end

      it 'fails to log in' do
        post user_sessions_path, params: invalid_params

        expect(response).to redirect_to(new_user_session_path(email: valid_user.email))
        follow_redirect!

        expect(response.body).to include('Login failed')
        expect(assigns(:user).email).to eq(valid_user.email)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) do
      create(:user,
        email: 'user@example.com',
        password: 'Password123!',
        password_confirmation: 'Password123!'
      )
    end

    context 'when user is authenticated and matches current user' do
      before do
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user).and_return(user)
      end

      it 'logs out the user' do
        delete user_session_path(id: user.id)

        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not authenticated' do
      before do
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user).and_return(nil)
      end

      it 'returns unauthorized status' do
        delete user_session_path(id: user.id)

        expect(session[:user_id]).to be_nil
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('401 Unauthorized')
      end
    end

    context 'when user is authenticated but does not match current user' do
      let(:another_user) { create(:user) }

      before do
        allow_any_instance_of(ApplicationController)
          .to receive(:current_user).and_return(another_user)
      end

      it 'returns unauthorized status' do
        delete user_session_path(id: user.id)

        expect(session[:user_id]).to be_nil
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to eq('401 Unauthorized')
      end
    end
  end
end
