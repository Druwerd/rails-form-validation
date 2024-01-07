require 'rails_helper'

RSpec.describe 'UsersController', type: :request do
  describe 'GET #new' do
    it 'renders the new template' do
      get new_user_path
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          user: {
            email: 'user@example.com',
            password: 'Password123!',
            password_confirmation: 'Password123!'
          }
        }
      end

      it 'creates a new user' do
        expect do
          post users_path, params: valid_params
        end.to change(User, :count).by(1)

        expect(response).to redirect_to(root_path)
        follow_redirect!

        expect(response).to render_template(:index) # Adjust to the correct template if needed
        expect(response.body).to include('User created')
        expect(response.body).to include('Welcome, user@example.com')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          user: {
            email: 'invalid_email',
            password: 'short',
            password_confirmation: 'not_matching'
          }
        }
      end

      it 'does not create a new user' do
        expect do
          post users_path, params: invalid_params
        end.not_to change(User, :count)

        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('User not created')
      end
    end
  end
end
