require 'rails_helper'

RSpec.describe FormValidations::UsersController, type: :request do
  let(:user) do
     User.new
  end
  describe 'POST #create' do
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

      it 'returns form errors as HTML' do
        post form_validations_users_path params: invalid_params, format: :text

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('users/_form_errors')
        expect(response.body).to match(/Email is invalid/)
        expect(response.body).to match(/Password is too short/)
        expect(response.body).to match(/Password must contain at least one uppercase letter/)
        expect(response.body).to match(/Password must contain at least one number/)
        expect(response.body).to match(/Password must contain at least one special character/)
        expect(response.body).to match(/Password confirmation doesn&#39;t match Password/)
      end
    end

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

      it 'returns no form errors' do
        post form_validations_users_path params: valid_params, format: :text

        expect(response).to have_http_status(:ok)
        expect(response).to render_template('users/_form_errors')
        expect(response.body).to be_empty
      end
    end
  end
end
