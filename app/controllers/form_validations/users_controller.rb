class FormValidations::UsersController < UsersController
  def create
    @user = User.new(user_params)
    @user.validate # Uses model valiations to validate the form
    respond_to do |format|
      format.text do
        render partial: "users/form_errors", locals: { user: @user }, formats: [:html]
      end
    end
  end
end
