class FormValidations::UsersController < UsersController
  def update
    @user.assign_attributes(user_params)
    @user.valid?
    respond_to do |format|
      format.text do
        render partial: "users/form_errors", locals: { user: @user }, formats: [:html]
      end
    end
  end

  def create
    @user = User.new(user_params)
    @user.validate
    respond_to do |format|
      format.text do
        render partial: "users/form_errors", locals: { user: @user }, formats: [:html]
      end
    end
  end
end
